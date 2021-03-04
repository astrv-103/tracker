function [trm,drm,krm, crm, miner] = shapeteke( alls )
%SHAPETEKE Summary of this function goes here
%   Detailed explanation goes here
    alls = alls / max(alls);
    afg = sum(alls>0);
    miner = 10000000000000000000000;
    for tr = 0.1:0.1:0.4
        for dr =6:12
            for kr =3:35
                for cr = 40:0.5:50
                    allk = cometfun(1:length(alls),dr,kr,tr,cr );
                    allk = allk.*(alls>0);
                    if sum(abs(allk - alls))/afg<miner
                        miner = sum(abs(allk - alls))/afg;
                        trm = tr;
                        drm = dr;
                        krm = kr;
                        crm = cr;

                     end

                end
            end
        end
    end

end

