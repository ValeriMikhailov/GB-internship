Образцы реализации методов класса GBServerManager:

    // Вовзращает массив персон (GBPersonAPI) по ID сайта, каждая персона включает в себя массив статистики (GBStatisticAPI), в свойствах которой есть дата старта (statistic.startDate) подсчета статистики и рейтинга личностию Пример вывода: 
    Жириновский - 206 - 2017-03-01 00:00:00 +0000
    Медведев - 226 - 2010-03-17 00:00:00 +0000
    Путин - 223 - 2010-03-17 00:00:00 +0000
    
    // 
    [[GBServerManager sharedManager] getArrayBySiteID:1 onSuccess:^(NSArray *statisticArray) {
        
        for (GBPersonAPI* obj in statisticArray) {
            GBStatisticAPI* stat = [obj.statistic firstObject];
            NSLog(@"%@ - %ld - %@", obj.personName, (long)stat.rank, stat.startDate);
        }
    } onFailure:^(NSError *error) {
        
    }];
    
    [[GBServerManager sharedManager] getArrayOfAvaliableSitesOnSuccess:^(NSArray *sitesArray) {
        for (GBSiteAPI* obj in sitesArray) {
            NSLog(@"%ld - %@", obj.siteID, obj.siteURL);
        }
    } onFailure:^(NSError *error) {
        
    }];
    
    [[GBServerManager sharedManager] getArrayOfAvaliablePersonsOnSuccess:^(NSArray *personsArray) {
        for (GBPersonAPI* obj in personsArray) {
            
            NSLog(@"%@ - %ld", obj.personName, obj.personID);
        }
    } onFailure:^(NSError *error) {
        
    }];

