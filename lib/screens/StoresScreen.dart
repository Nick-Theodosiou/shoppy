import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shoppy/styles/colors.dart';


class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StoresScreenDemo(),
    );
  }
}




class StoresScreenDemo extends StatefulWidget {
  const StoresScreenDemo({super.key});
  @override
  _StoresScreenState createState() => _StoresScreenState();
}


class _StoresScreenState extends State<StoresScreenDemo> {
  @override
  List<String> Supermarkets=['https:encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYByPO5YKv2ls4DlQOWvEtpRVLHpLAKrUoVH8keqJX&s','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAASwAAACoCAMAAABt9SM9AAAAwFBMVEX///8ecbjMIikAZLMAZ7QAabXIAADJ2OoQbbZyncz6/P3E1Ojm7vYNbLYmdbqApc9Ti8QAdL0AYrK4y+Olv93LGyOiQGLPHyJpl8ny9vuOrtTa5fHKABHJAAqHqtK0yeL57O313d7RRkv57u7KDxnqurzNJy7uxsf89vbnra/y1NXZcHPeh4qpwd5AgL9ik8fgkZTWX2Pqt7jUW2DONTvTTVLcfYDkoKLZc3fQQEUAWq/NMDfdbW02fL2fLFO1lq2rN8vVAAAHNklEQVR4nO2d6UKbShSACVtQg7FUmhiISQzVmNa41C722tv3f6sLYRtglsNgLtCe729wOPN1BoYzB6ooCIIgCIIgCIIgCIIgCIIgCIIgCIIgCIIgCIIgCPK3sLl5eL16uXr8/LRuO5Suc/Nq+oEbEfjm1ce2w+kyqytzoua48+ubtkPqLA+mqxZxzU9tB9VRvszVKsHzpu24usjXgOJKVScq2qrwie4qnIovbYfWOW5NhitV9b+1HVzH2LBdqaq5bTu8bvGDNQlxIlZY8wYWDq0i33kDK7wj4mqL4KW8Gi0PrbYD7BDcyzvOwyJb2tqdxL9tO8Tu8OQLZAUPbYfYHW6FsnBdmoGyaiCehp/bDrE73Igu8MH3tkPsDkvR0mGOGdMcVbQoxZxWzmf+4477te0Au8SKPw/9p7YD7BRfufMwaDu8brHlDa05PuwU4WT//pDc3/EIzoWgrWvmRDSX1HPXgnna3RmYywamQryfGpSfC0FbyznDFiM9c+aAzx2hD87Gi1G1Gc2CYk8bytIHUIz3osZWPs2WazLWo1MLfO4Yyza00/PyADfgf98lWcr6ufqIGExWjKOndk1ZcRjOuKirr7KiYofiZX7CKXWQkzUY2Nr5nyFLWX8z/bSOxvXNR9awaiArDGVHDC54DzonS1E2T59UMyJ4vF3yDpSXFV698it9j0dWzGa5WgqfnBvIGgz0zBa8laayhoeRBaKRrIGRzsQ/Q9bW5Q+ue93YI6Mq7PmvpBlHB7SyP0S7l3KUMYwXpfxTWbBFaYmVObnm2jq5W0TcSdoyxkkzMdxWTof7Y4aymopx805lj2WajHI2Lt9WzLEmJ2vgeGQz3FZOZXrA4v2by4rzWxBb0rKsHbiVbstKc4GuuERSWtZAO4G28rayeNd5CVl53tRVRW8OyMsih1Z/R9aKqPB2XYEtbjdt3eAsDbQRrJUuy1oVcjUiW7xu2rPRcGYxg7NnoFa6LKuc1xLY4nXT2D8y3zGPOAW10mFZy0pWi29LLEsZsaZiPg/7KavqKrQVLNl/AJCleA7j9wWklc7Korni24LIUmb0APPQLnooaxnQ8/AcWyBZrERMtnjooSyWqygRuGT8zZZzbuMuPWpMv2zp6e/9k8V2xba1Nd9BZDGeXrU0UdM7WWuOK5atG1MFyWLI0D3+752VtXb5ZUc0W6ErmCxGVkFPsy49k7UWlWip7ry8fRG5AsqibzIa6bN0v2SJXVVt7V25PFl5wpFxQJq+7ZUsiKuyrb0rdQKTRb8b9lLWBuQq2svPbX2M8zhAWXQZzWWJyl3eTpaX3Iw27Aoapq2nJOcFkzWiZ9yaXuBH9/Ura+RkXUx/Dmu6Cklspa7UACRrQY+w2dLheOzoM/pPbyzr+FKz4n/YWq4SW5kroKx7+t2w0aJ0ptlkSuyAss51O5kFm38mPDcUW1vClTqHyBoxXGhpOPVl3dlRp/8PWYs4fRnJqu1KVf2H3JX/CpHFGFiDdKe1tqyT07jLh5c1/JVcbkNZm+daczAmr0vyH3llMKmsc8Yx1pGcLG+XHn5oWd5ZFlgo67n2uCqMsUduzVCyMpixTAifHamyRvdaNlAPK2s0dfIpYQxfmrl6VcSy3v9iRpenleGyLsZEB2RkMW7MVVnHl+SZBu8+8N9CgbjiybLuj3a8QoxcAlhWdAskO3e4kbW/BRZkNRlYsStu6Z7FLdIlegqUdVcutznYyFrY5cMayfKTclN41VMZYpMVJCu9BZKdq7+Ch8g6Oa32qoms1JW8LOss7wFAlrejnOkgsohbIEEiS2LxoPo/0pNLy9KIeiuhLPIWSHbu7WWNptQzJbKCL/WedyLmmStpWYWSI5GsI4ee43lrWdbRzGFcZ/eygi/cnQqRqxrlxkUKxWyCWhybtaddR9bxxR5+qaLFLGSJZEXrSsbeKttV9OECL65vHErW4RrxfcxLXnSSa6SWrHNITSmbUFZy/2e+5cR0pVw6TQpw7WQSevGLTpIdqCdLVlPMuw9mOp9Wla9uClwps0al3VaSnKlRyU+jznZ7U1n/5h8CAdtKXDWTZaRLrP7Isn8TbQneKc9cpd8OaSDLsrLlaH9kGYXKcu5r0ilm9p0VeVnGLn+xtUeyTgqtAWzlrqRlWYVX6HorS2yLcCUpy3amhd2r/soS2SJdSciybN0Yl16T7rGsZJcZ4ipbZ8HQdU3bzapv33gO+IVyGsZRpUW2LEdvglORxbNVdJWu4IEMPcqb90qUuT1qwvSc2ir9VMNmUDa/mbZM/OxfFYYtdEXlI80WumJAsYWumDyVbaErDqUv6aMrLgVb6ErAbb79auJnN/lsrlx0BWRzPUFXQJYujisoxFfH0JWArYmuoBA5LRM/uclnQ4wrdCUi2+VBVwASW+gKxH6/FV0BCW2hKzArE79pDgf/YwEEQRAEQRAEQRAEQRAEQRAEQRAEQRAEQRAEQf4e/gPy9LbfU8Hk4AAAAABJRU5ErkJggg=='];
Widget build(BuildContext context) {
    return Scaffold(
      body:  ListView.builder(
        padding: EdgeInsets.zero,
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: Supermarkets.length,
        //itemCount: cartItems.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: ShoppyColors.gray,
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  const BoxShadow(
                    blurRadius: 4,
                    color: Color(0x320E151B),
                    offset: Offset(0, 1),
                  )
                ],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 8, 8, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Image.network(Supermarkets[index],
                          //cartItems[index].image,
                          width: 80,
                          height: 80,
                          fit: BoxFit.fitWidth,
                        ),
                        IconButton(
                      icon: const Icon(
                        Icons.favorite,
                        //color: Color(0xFFE86969),
                        size: 20,
                      ),
                       onPressed: () {
                      // Favorite Supermarket /Unfavorite Supermarket
                      },
                      ),
                  ],
                ),
              ),
            ),
          );
        }),
    );
  }
  
}
