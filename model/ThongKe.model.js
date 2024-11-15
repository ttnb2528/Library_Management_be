import connection from "../config/db.js";

const ThongKe = {
    getThongKeMuonSach: (so_thang, callback) => {
        const query = `CALL ThongKeMuonSach(?, @so_lan_muon, @so_cuon_sach_muon);
        SELECT @so_lan_muon AS SoLanMuon, @so_cuon_sach_muon AS SoCuonSachMuon`;
        // connection.query("CALL ThongKeMuonSach(?, @so_lan_muon, @so_cuon_sach_muon)", [so_thang], callback);
        connection.query(query, [so_thang], callback);
    }
}

export default ThongKe;

