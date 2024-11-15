import { StatusCode } from "../utils/constants.js";
import { jsonGenerate } from "../utils/helpers.js";
import ThongKe from "../model/ThongKe.model.js";

export const getThongKeMuonSach = async (req, res) => {
    let { so_thang } = req.body;

    console.log(so_thang);
    

    if (!so_thang) {
        so_thang = 1;
    }

    ThongKe.getThongKeMuonSach(so_thang, (err, result) => {
        if (err) return res.json(jsonGenerate(StatusCode.INTERNAL_SERVER_ERROR, err));
        res.json(jsonGenerate(StatusCode.OK, "Thành công", result[1]));
    });
};
