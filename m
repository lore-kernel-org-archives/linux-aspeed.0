From: Klaus Kudielka <klaus.kudielka@gmail.com>
Date: Sat, 11 Mar 2023 17:11:08 +0100
Subject: [PATCH net-next v2 4/6] net: mdio: scan bus based on bus
 capabilities for C22 and C45
In-Reply-To: <a57a216d-ff5a-46e6-9780-e53772dcefc8@lunn.ch>
References: <100c439a-2a4d-4cb2-96f2-5bf273e2121a@lunn.ch>
	 <712bc92ca6d576f33f63f1e9c2edf0030b10d3ae.camel@gmail.com>
	 <db6b8a09-b680-4baa-8963-d355ad29eb09@lunn.ch>
	 <0e10aa8492eadb587949d8744b56fccaabbd183b.camel@gmail.com>
	 <72530e86-9ba9-4a01-9cd2-68835ecae7a0@lunn.ch>
	 <09d65e1ee0679e1e74b4f3a5a4c55bd48332f043.camel@gmail.com>
	 <70f5bca0-322c-4bae-b880-742e56365abe@lunn.ch>
	 <10da10caea22a8f5da8f1779df3e13b948e8a363.camel@gmail.com>
	 <4abd56aa-5b9f-4e16-b0ca-11989bb8c764@lunn.ch>
	 <bff0e542b8c04980e9e3af1d3e6bf739c87eb514.camel@gmail.com>
	 <a57a216d-ff5a-46e6-9780-e53772dcefc8@lunn.ch>
Message-ID: <2f64385a350359c5755eb4d2479e2efef7a96216.camel@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, 2023-03-11 at 16:39 +0100, Andrew Lunn wrote:
> 
> I have one more idea which can speed things up. The scanning of the
> MDIO bus works in two different ways depending on if there is a DT
> node, describing what should be found on the bus. For mv88e6xxx, using
> DT is optional. Some boards do, some don't.
> 
> If there is a DT node, only the addresses listed in DT are scanned.

Here's the definition of the switch in the Turris Omnia device tree.

	/* Switch MV88E6176 at address 0x10 */
	switch at 10 {
		pinctrl-names = "default";
		pinctrl-0 = <&swint_pins>;
		compatible = "marvell,mv88e6085";
		#address-cells = <1>;
		#size-cells = <0>;

		dsa,member = <0 0>;
		reg = <0x10>;

		interrupt-parent = <&gpio1>;
		interrupts = <13 IRQ_TYPE_LEVEL_LOW>;

		ports {
			#address-cells = <1>;
			#size-cells = <0>;

			ports at 0 {
				reg = <0>;
				label = "lan0";
			};

			ports at 1 {
				reg = <1>;
				label = "lan1";
			};

			ports at 2 {
				reg = <2>;
				label = "lan2";
			};

			ports at 3 {
				reg = <3>;
				label = "lan3";
			};

			ports at 4 {
				reg = <4>;
				label = "lan4";
			};

			ports at 5 {
				reg = <5>;
				label = "cpu";
				ethernet = <&eth1>;
				phy-mode = "rgmii-id";

				fixed-link {
					speed = <1000>;
					full-duplex;
				};
			};

			ports at 6 {
				reg = <6>;
				label = "cpu";
				ethernet = <&eth0>;
				phy-mode = "rgmii-id";

				fixed-link {
					speed = <1000>;
					full-duplex;
				};
			};
		};

> 
> If there is no DT node, by default, all 32 addresses on the bus are
> scanned. However, DSA makes another assumption. There is a one to one
> mapping between port number and PHY address on the MDIO bus. Port 0
> uses MDIO address 0. Port 7 uses MDIO address 7 etc. If you have an 8
> port switch, there is no point scanning addresses 8 to 31, they will
> never be used.
> 
> The mdio bus structure has a member phy_mask. This is a bitmap. If bit
> N is set, address N is not scanned. So i suggest you extend
> mv88e6xxx_mdio_register() to set phy_mask based on
> mv88e6xxx_num_ports(chip).
> 

What you are proposing here would not show any improvement on the
Omnia, as only the 6 ports would be scanned - right? 

> ????????Andrew

