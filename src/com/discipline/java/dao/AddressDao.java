package com.discipline.java.dao;

import com.discipline.java.bean.Address;
import java.sql.SQLException;
import java.util.List;

public interface AddressDao {
    List<Address> getAddressList(int uid) throws SQLException;
    int insertAddress(Address address) throws SQLException;
    int deleteAddress(int id)throws  SQLException;
    int updateAddress(Address address)throws SQLException;
    Address getAddress(int id)throws SQLException;
}
