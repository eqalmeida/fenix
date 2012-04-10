dataSource {
    pooled = true

    //driverClassName = "org.hsqldb.jdbcDriver"
    //username = "sa"
    //password = ""

    driverClassName = "com.mysql.jdbc.Driver"                              // or "update"   (after you run with create-drop )

    username = "root"
    password = "root"
    dialect='org.hibernate.dialect.MySQL5InnoDBDialect'

}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.provider_class = 'net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
    development {
        dataSource {
//            dbCreate = "create-drop" // one of 'create', 'create-drop','update'
//            url = "jdbc:mysql://localhost/fenix_dev"
            dbCreate = "update"
            url = "jdbc:mysql://localhost/fenix"
        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:mysql://localhost/fenix_test"
        }
    }
    production {
        dataSource {
            dbCreate = "update"
            url = "jdbc:mysql://localhost/fenix"
        }
    }
}
