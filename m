From: Andrew Lunn <andrew@lunn.ch>
Date: Fri, 25 Mar 2022 01:10:20 +0100
Subject: [PATCH] ARM: dts: aspeed: add Nuvia DC-SCM BMC
In-Reply-To: <a70bde19-3ded-d8ae-51ff-ec37fa803b06@quicinc.com>
References: <20220324164551.359570-1-quic_jaehyoo@quicinc.com>
 <YjzhT4gOJ9SKy6q+@lunn.ch>
 <88849423-c4a5-0a68-1900-72196395704e@quicinc.com>
 <Yjzub26okJosPkXC@lunn.ch>
 <a70bde19-3ded-d8ae-51ff-ec37fa803b06@quicinc.com>
Message-ID: <Yj0IbLsebBvZdaZE@lunn.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> The clock delay I mentioned is added into u-boot bootloader in a
> patch I'm currently trying to submit.
> https://lore.kernel.org/all/20220324165530.359668-1-quic_jaehyoo at quicinc.com/

Do you mean this:

+&scu {
+	mac0-clk-delay = <0x1d 0x1c
+			  0x10 0x17
+			  0x10 0x17>;
+	mac1-clk-delay = <0x1d 0x10
+			  0x10 0x10
+			  0x10 0x10>;
+	mac2-clk-delay = <0x0a 0x04
+			  0x08 0x04
+			  0x08 0x04>;
+	mac3-clk-delay = <0x0a 0x04
+			  0x08 0x04
+			  0x08 0x04>;

So the MAC is adding the delay. In that case, setting phy-mode to
rgmii is O.K, but it would be nice to add a comment in DT that the
bootloader is setting up the MAC to insert the delay.

	   Andrew
