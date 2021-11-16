package com.discipline.java.service.impl;

import com.discipline.java.bean.Address;
import com.discipline.java.dao.AddressDao;
import com.discipline.java.dao.impl.AddressDaoImpl;
import com.discipline.java.service.AddressService;
import com.discipline.java.utils.DruidUtils;

import java.sql.SQLException;
import java.util.List;

public class AddressServiceImpl implements AddressService {
    private AddressDao addressDao = new AddressDaoImpl();

    @Override
    public List<Address> getAddressList(int uid) throws SQLException {
        return addressDao.getAddressList(uid);
    }

    @Override
    public int insertAddress(Address address) throws SQLException {
        List<Address> addressList = addressDao.getAddressList(address.getUid());
        //默认单个用户最多拥有3个地址列表
        if (addressList.size() >= 3)
            return 2;

        //如果插入记录为默认地址
        if(address.getLevel()==1&&addressList.size()>0){
            //遍历addressList查询是否存在默认地址
            Address defaultAddress = getDefaultAddress(addressList);
            //存在默认地址 defaultAddress
            if(defaultAddress!=null){
                //defaultAddress 置为备选地址
                defaultAddress.setLevel(0);
                //开始事务
                DruidUtils.startTX();
                try {
                    addressDao.updateAddress(defaultAddress);
                    addressDao.insertAddress(address);
                }catch (SQLException e) {
                    e.printStackTrace();
                    DruidUtils.rollbackTX();
                    throw e;
                }
                DruidUtils.endTx();
                return 1;
            }


        }
        return addressDao.insertAddress(address);


    }

    @Override
    public int deleteAddress(int id) throws SQLException {
        return addressDao.deleteAddress(id);
    }

    @Override
    public int updateAddress(Address address) throws SQLException {

        //如果更新记录为默认地址
        if(address.getLevel()==1){
            List<Address> addressList = addressDao.getAddressList(address.getUid());
            if(addressList.size()>1){
                //遍历addressList查询是否存在默认地址
                Address defaultAddress = getDefaultAddress(addressList);
                //存在默认地址 defaultAddress
                if(defaultAddress!=null){
                    //defaultAddress 置为备选地址
                    defaultAddress.setLevel(0);
                    //开始事务
                    DruidUtils.startTX();
                    try {
                        addressDao.updateAddress(defaultAddress);
                        addressDao.updateAddress(address);
                    }catch (SQLException e) {
                        e.printStackTrace();
                        DruidUtils.rollbackTX();
                        throw e;
                    }
                    DruidUtils.endTx();
                    return 1;
                }
            }
            return addressDao.updateAddress(address);

        }
        return addressDao.updateAddress(address);

    }

    @Override
    public Address getAddress(int id) throws SQLException {
        return addressDao.getAddress(id);
    }

    //获取用户默认地址
    public Address getDefaultAddress(List<Address> list) {
        for (Address address : list) {
            if (address.getLevel() == 1)
                return address;
        }
        return null;
    }
}

