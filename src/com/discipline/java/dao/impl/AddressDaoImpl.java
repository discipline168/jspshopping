package com.discipline.java.dao.impl;

import com.discipline.java.bean.Address;
import com.discipline.java.dao.AddressDao;
import com.discipline.java.utils.DruidUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import java.sql.SQLException;
import java.util.List;

public class AddressDaoImpl implements AddressDao {
    private QueryRunner queryRunner=new QueryRunner(DruidUtils.getDataSource());

    @Override
    public List<Address> getAddressList(int uid) throws SQLException {
        return queryRunner.query("SELECT * FROM tb_address WHERE uid = ?",
                new BeanListHandler<>(Address.class),uid);
    }

    @Override
    public int insertAddress(Address address) throws SQLException {
        return queryRunner.update(DruidUtils.getConnection(),
                "INSERT INTO tb_address(region,detail,uid,name,phone,level) VALUES (?, ?, ?, ?, ? ,?)",
                address.getRegion(),address.getDetail(),address.getUid(),
                address.getName(),address.getPhone(),address.getLevel());
    }

    @Override
    public int deleteAddress(int id) throws SQLException {
        return queryRunner.update(DruidUtils.getConnection(),
                "DELETE FROM tb_address WHERE id=?",
                id);
    }

    @Override
    public int updateAddress(Address address) throws SQLException {
        return queryRunner.update(DruidUtils.getConnection(),
                "UPDATE tb_address SET region=?, detail=?, name=?, phone=?, level=?  WHERE id=?",
                address.getRegion(),address.getDetail(),address.getName(),
                address.getPhone(),address.getLevel(),address.getId());
    }

    @Override
    public Address getAddress(int id) throws SQLException {
        return queryRunner.query("SELECT * FROM tb_address WHERE id = ?",
                new BeanHandler<>(Address.class),id);
    }
}
