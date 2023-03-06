From: Klaus Kudielka <klaus.kudielka@gmail.com>
Date: Mon, 06 Mar 2023 19:40:21 +0100
Subject: [PATCH net-next v2 4/6] net: mdio: scan bus based on bus
 capabilities for C22 and C45
In-Reply-To: <100c439a-2a4d-4cb2-96f2-5bf273e2121a@lunn.ch>
References: <20230116-net-next-remove-probe-capabilities-v2-0-15513b05e1f4@walle.cc>
	 <20230116-net-next-remove-probe-capabilities-v2-4-15513b05e1f4@walle.cc>
	 <449bde236c08d5ab5e54abd73b645d8b29955894.camel@gmail.com>
	 <100c439a-2a4d-4cb2-96f2-5bf273e2121a@lunn.ch>
Message-ID: <712bc92ca6d576f33f63f1e9c2edf0030b10d3ae.camel@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, 2023-03-05 at 19:35 +0100, Andrew Lunn wrote:
> On Sun, Mar 05, 2023 at 07:13:09PM +0100, Klaus Kudielka wrote:
> > On Wed, 2023-01-18 at 11:01 +0100, Michael Walle wrote:
> > > From: Andrew Lunn <andrew@lunn.ch>
> > > 
> > > Now that all MDIO bus drivers which set probe_capabilities to
> > > MDIOBUS_C22_C45 have been converted to use the name API for C45
> > > transactions, perform the scanning of the bus based on which methods
> > > the bus provides.
> > > 
> > > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > > Signed-off-by: Michael Walle <michael@walle.cc>
> > > Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> > 
> > Hello,
> > 
> > On a Turris Omnia (Armada 385, Marvell 88E6176) this commit results
> > in a strange boot behaviour. I see two distinct multi-second freezes
> > in dmesg. Usually (up to the commit before), the (monolithic) kernel
> > starts init after ~1.6 seconds, now it takes more than 6....
> > 
> > dmesg output below. Any idea, why this is happening?
> 
> The Armada 385 uses mdio-orian, also known as
> drivers/net/ethernet/marvell/mvmdio.c. It comes in two variants, one
> which supports only C22 and one which only supports C45, if i'm
> reading orion_mdio_match[] correctly.
> 
> Please could you add a debug print in orion_mdio_smi_read() and
> orion_mdio_xsmi_read_c45() and see if there is a difference before and
> after this patch.
> 
> I'm assuming here the problem is with the MDIO bus associated to
> mvneta, and not the mdio bus associated to the switch. That assumption
> could be wrong, but the printk's should help with that as well.
> 
> ????? Andrew


I just added

dev_warn_ratelimited(bus->parent, "<function_name> %d\n", mii_id);

at the entry point of each function. And here we go.



########
# good: [3486593374858b41ae6ef7720cb28ff39ad822f3] net: mdio: Add workaround for Micrel PHYs which are not C45 compatible

*** snip ***
[    0.194348] Creating 3 MTD partitions on "spi0.0":
[    0.194353] 0x000000000000-0x0000000f0000 : "U-Boot"
[    0.194534] 0x000000100000-0x000000800000 : "Rescue system"
[    0.194652] 0x0000000f0000-0x000000100000 : "u-boot-env"
[    0.195518] orion-mdio f1072004.mdio: orion_mdio_smi_read 1
[    0.195592] orion-mdio f1072004.mdio: orion_mdio_smi_read 1
[    0.202202] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[    0.202280] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[    0.202346] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[    0.202470] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[    0.202534] mv88e6085 f1072004.mdio-mii:10: switch 0x1760 detected: Marvell 88E6176, revision 1
[    0.202542] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[    0.202674] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[    0.202799] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[    0.202921] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[    0.320192] mvneta_bm f10c8000.bm: Buffer Manager for network controller enabled
*** snip ***
[    1.598893] Run /init as init process
[    1.598896]   with arguments:
[    1.598898]     /init
[    1.598900]   with environment:
[    1.598902]     HOME=/
[    1.598904]     TERM=linux
*** snip ***
[    4.628127] mv88e6085 f1072004.mdio-mii:10 lan3: Link is Up - 1Gbps/Full - flow control rx/tx
[    4.628150] IPv6: ADDRCONF(NETDEV_CHANGE): lan3: link becomes ready
[    4.628210] br0: port 2(lan3) entered blocking state
[    4.628219] br0: port 2(lan3) entered forwarding state
[    4.629187] IPv6: ADDRCONF(NETDEV_CHANGE): br0: link becomes ready
[  283.962353] orion_mdio_smi_read: 9231 callbacks suppressed
[  283.962361] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  283.962492] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  283.962617] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  283.962799] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  283.962981] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  283.963162] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  283.963344] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  283.963466] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  283.963588] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  283.963652] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  310.572411] orion_mdio_smi_read: 56 callbacks suppressed
[  310.572419] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  310.572550] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  310.572675] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  310.572857] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  310.573039] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  310.573220] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  310.573402] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  310.573524] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  310.573647] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  310.573711] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  726.308614] orion_mdio_smi_read: 56 callbacks suppressed
[  726.308623] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  726.308754] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  726.308879] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  726.309060] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  726.309242] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  726.309423] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  726.309604] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  726.309727] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  726.309850] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  726.309914] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  841.713791] orion_mdio_smi_read: 56 callbacks suppressed
[  841.713800] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  841.713931] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  841.714056] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  841.714239] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  841.714420] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  841.714602] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  841.714783] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  841.714906] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  841.715029] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  841.715093] orion-mdio f1072004.mdio: orion_mdio_smi_read 16



#####
# first bad commit: [1a136ca2e089d91df8eec0a796a324171373ffd8] net: mdio: scan bus based on bus capabilities for C22 and C45

*** snip ***
[    0.191685] Creating 3 MTD partitions on "spi0.0":
[    0.191690] 0x000000000000-0x0000000f0000 : "U-Boot"
[    0.191871] 0x000000100000-0x000000800000 : "Rescue system"
[    0.191991] 0x0000000f0000-0x000000100000 : "u-boot-env"
[    0.192830] orion-mdio f1072004.mdio: orion_mdio_smi_read 1
[    0.192906] orion-mdio f1072004.mdio: orion_mdio_smi_read 1
[    0.199530] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[    0.199610] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[    0.199677] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[    0.199799] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[    0.199864] mv88e6085 f1072004.mdio-mii:10: switch 0x1760 detected: Marvell 88E6176, revision 1
[    0.199871] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[    0.199994] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[    0.200117] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[    0.200239] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[    0.396608] ata2: SATA link down (SStatus 0 SControl 300)
[    0.554697] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.555370] ata1.00: supports DRM functions and may not be fully accessible
[    0.555375] ata1.00: ATA-10: KINGSTON SKC600MS512G, S4800105, max UDMA/133
[    0.555385] ata1.00: 1000215216 sectors, multi 1: LBA48 NCQ (depth 32)
[    0.556058] ata1.00: Features: Trust Dev-Sleep
[    0.556158] ata1.00: supports DRM functions and may not be fully accessible
[    0.556811] ata1.00: configured for UDMA/133
[    0.556985] scsi 0:0:0:0: Direct-Access     ATA      KINGSTON SKC600M 0105 PQ: 0 ANSI: 5
[    0.557485] sd 0:0:0:0: [sda] 1000215216 512-byte logical blocks: (512 GB/477 GiB)
[    0.557493] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    0.557515] sd 0:0:0:0: [sda] Write Protect is off
[    0.557520] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.557553] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.557620] sd 0:0:0:0: [sda] Preferred minimum I/O size 4096 bytes
[    0.558111]  sda: sda1
[    0.558230] sd 0:0:0:0: [sda] Attached SCSI removable disk
[    2.741909] mvneta_bm f10c8000.bm: Buffer Manager for network controller enabled
*** snip ***
[    3.213998] sfp sfp: module TP-LINK          TL-SM321B        rev      sn 1403076900       dc 140401
[    3.214020] mvneta f1034000.ethernet eth2: switched to inband/1000base-x link mode
[    5.194695] orion_mdio_smi_read: 43968 callbacks suppressed
[    5.194701] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[    5.194767] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[    5.194891] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[    5.195014] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[    5.195137] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[    5.195259] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[    5.195324] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[    5.195446] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[    5.195510] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[    5.195633] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[    6.223184] mv88e6085 f1072004.mdio-mii:10: configuring for fixed/rgmii-id link mode
[    6.224852] mv88e6085 f1072004.mdio-mii:10: configuring for fixed/rgmii-id link mode
[    6.226126] mv88e6085 f1072004.mdio-mii:10: Link is Up - 1Gbps/Full - flow control off
[    6.229455] mv88e6085 f1072004.mdio-mii:10: Link is Up - 1Gbps/Full - flow control off
[    6.294120] mv88e6085 f1072004.mdio-mii:10 lan0 (uninitialized): PHY [mv88e6xxx-1:00] driver [Marvell 88E1540] (irq=68)
[    6.366663] mv88e6085 f1072004.mdio-mii:10 lan1 (uninitialized): PHY [mv88e6xxx-1:01] driver [Marvell 88E1540] (irq=69)
[    6.438843] mv88e6085 f1072004.mdio-mii:10 lan2 (uninitialized): PHY [mv88e6xxx-1:02] driver [Marvell 88E1540] (irq=70)
[    6.510122] mv88e6085 f1072004.mdio-mii:10 lan3 (uninitialized): PHY [mv88e6xxx-1:03] driver [Marvell 88E1540] (irq=71)
[    6.582302] mv88e6085 f1072004.mdio-mii:10 lan4 (uninitialized): PHY [mv88e6xxx-1:04] driver [Marvell 88E1540] (irq=72)
[    6.584680] device eth1 entered promiscuous mode
[    6.585573] device eth0 entered promiscuous mode
[    6.585593] DSA: tree 0 setup
[    6.586408] Freeing unused kernel image (initmem) memory: 1024K
[    6.586547] Run /init as init process
[    6.586551]   with arguments:
[    6.586553]     /init
[    6.586555]   with environment:
[    6.586557]     HOME=/
[    6.586559]     TERM=linux
*** snip ***
[    9.437029] mv88e6085 f1072004.mdio-mii:10 lan3: Link is Up - 1Gbps/Full - flow control rx/tx
[    9.437052] IPv6: ADDRCONF(NETDEV_CHANGE): lan3: link becomes ready
[    9.437116] br0: port 2(lan3) entered blocking state
[    9.437125] br0: port 2(lan3) entered forwarding state
[    9.438061] IPv6: ADDRCONF(NETDEV_CHANGE): br0: link becomes ready
[    9.469466] systemd-journald[207]: Time jumped backwards, rotating.
[  414.675728] orion_mdio_smi_read: 11201 callbacks suppressed
[  414.675736] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  414.675869] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  414.675996] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  414.676179] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  414.676361] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  414.676543] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  414.676725] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  414.676847] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  414.676970] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  414.677034] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  540.809740] orion_mdio_smi_read: 56 callbacks suppressed
[  540.809748] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  540.809879] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  540.810004] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  540.810186] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  540.810368] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  540.810551] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  540.810732] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  540.810855] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  540.810978] orion-mdio f1072004.mdio: orion_mdio_smi_read 16
[  540.811042] orion-mdio f1072004.mdio: orion_mdio_smi_read 16



"orion_mdio_smi_read: 43968 callbacks suppressed" after 5 seconds - quite impressive!


Best regards, Klaus

