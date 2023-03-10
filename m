From: Klaus Kudielka <klaus.kudielka@gmail.com>
Date: Fri, 10 Mar 2023 21:22:56 +0100
Subject: [PATCH net-next v2 4/6] net: mdio: scan bus based on bus
 capabilities for C22 and C45
In-Reply-To: <70f5bca0-322c-4bae-b880-742e56365abe@lunn.ch>
References: <20230116-net-next-remove-probe-capabilities-v2-0-15513b05e1f4@walle.cc>
	 <20230116-net-next-remove-probe-capabilities-v2-4-15513b05e1f4@walle.cc>
	 <449bde236c08d5ab5e54abd73b645d8b29955894.camel@gmail.com>
	 <100c439a-2a4d-4cb2-96f2-5bf273e2121a@lunn.ch>
	 <712bc92ca6d576f33f63f1e9c2edf0030b10d3ae.camel@gmail.com>
	 <db6b8a09-b680-4baa-8963-d355ad29eb09@lunn.ch>
	 <0e10aa8492eadb587949d8744b56fccaabbd183b.camel@gmail.com>
	 <72530e86-9ba9-4a01-9cd2-68835ecae7a0@lunn.ch>
	 <09d65e1ee0679e1e74b4f3a5a4c55bd48332f043.camel@gmail.com>
	 <70f5bca0-322c-4bae-b880-742e56365abe@lunn.ch>
Message-ID: <10da10caea22a8f5da8f1779df3e13b948e8a363.camel@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2023-03-09 at 17:36 +0100, Andrew Lunn wrote:
> 
> I was wrong about something i said earlier. A C22 scan reads two
> registers for each of the 32 possible locations of a C22 PHY on the
> bus. A C45 scan is however much more expensive. It will read 30 time
> two registers for each of the 32 possible locations of a C45 PHY on
> the bus.
> 
> One things that could help is moving some code around a bit. Currently
> mv88e6xxx_mdios_register() is called at the end of
> mv88e6xxx_probe(). Try moving it to the beginning of
> mv88e6xxx_setup(). The call to mv88e6xxx_mdios_unregister() then need
> to move into mv88e6xxx_teardown().
> 

Yes, that helps. Primarily, because mdiobus_scan_bus_c45 now is called only once,
and at least some things are done in parallel.

(Still, ~2s waiting for the C45 scan to complete).

[    0.382715] mdio_bus mv88e6xxx-0: *** mdiobus_scan_bus_c22 call ***
[    0.387571] mmc0: new high speed MMC card at address 0001
[    0.387953] mmcblk0: mmc0:0001 H8G4a\x92 7.28 GiB 
[    0.388929]  mmcblk0: p1
[    0.389197] mmcblk0boot0: mmc0:0001 H8G4a\x92 4.00 MiB 
[    0.389508] mmcblk0boot1: mmc0:0001 H8G4a\x92 4.00 MiB 
[    0.389850] mmcblk0rpmb: mmc0:0001 H8G4a\x92 4.00 MiB, chardev (250:0)
[    0.393323] ata2: SATA link down (SStatus 0 SControl 300)
[    0.486839] mdio_bus mv88e6xxx-0: *** mdiobus_scan_bus_c22 return ***
[    0.486850] mdio_bus mv88e6xxx-0: *** mdiobus_scan_bus_c45 call ***
[    0.554696] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.555373] ata1.00: supports DRM functions and may not be fully accessible
[    0.555378] ata1.00: ATA-10: KINGSTON SKC600MS512G, S4800105, max UDMA/133
[    0.555384] ata1.00: 1000215216 sectors, multi 1: LBA48 NCQ (depth 32)
[    0.556055] ata1.00: Features: Trust Dev-Sleep
[    0.556150] ata1.00: supports DRM functions and may not be fully accessible
[    0.556800] ata1.00: configured for UDMA/133
[    0.556981] scsi 0:0:0:0: Direct-Access     ATA      KINGSTON SKC600M 0105 PQ: 0 ANSI: 5
[    0.557506] sd 0:0:0:0: [sda] 1000215216 512-byte logical blocks: (512 GB/477 GiB)
[    0.557515] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    0.557552] sd 0:0:0:0: [sda] Write Protect is off
[    0.557557] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.557613] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.557736] sd 0:0:0:0: [sda] Preferred minimum I/O size 4096 bytes
[    0.558295]  sda: sda1
[    0.558417] sd 0:0:0:0: [sda] Attached SCSI removable disk
[    0.685992] sfp sfp: module TP-LINK          TL-SM321B        rev      sn 1403076900       dc 140401
[    0.686009] mvneta f1034000.ethernet eth2: switched to inband/1000base-x link mode
[    2.820390] mdio_bus mv88e6xxx-0: *** mdiobus_scan_bus_c45 return ***
[    3.464461] mv88e6085 f1072004.mdio-mii:10: configuring for fixed/rgmii-id link mode
[    3.466123] mv88e6085 f1072004.mdio-mii:10: configuring for fixed/rgmii-id link mode
[    3.467397] mv88e6085 f1072004.mdio-mii:10: Link is Up - 1Gbps/Full - flow control off
[    3.471263] mv88e6085 f1072004.mdio-mii:10: Link is Up - 1Gbps/Full - flow control off
[    3.538112] mv88e6085 f1072004.mdio-mii:10 lan0 (uninitialized): PHY [mv88e6xxx-0:00] driver [Marvell 88E1540] (irq=68)
[    3.602833] mv88e6085 f1072004.mdio-mii:10 lan1 (uninitialized): PHY [mv88e6xxx-0:01] driver [Marvell 88E1540] (irq=69)
[    3.674111] mv88e6085 f1072004.mdio-mii:10 lan2 (uninitialized): PHY [mv88e6xxx-0:02] driver [Marvell 88E1540] (irq=70)
[    3.746290] mv88e6085 f1072004.mdio-mii:10 lan3 (uninitialized): PHY [mv88e6xxx-0:03] driver [Marvell 88E1540] (irq=71)
[    3.818291] mv88e6085 f1072004.mdio-mii:10 lan4 (uninitialized): PHY [mv88e6xxx-0:04] driver [Marvell 88E1540] (irq=72)
[    3.820845] device eth1 entered promiscuous mode
[    3.821730] device eth0 entered promiscuous mode
[    3.821749] DSA: tree 0 setup
[    3.822563] Freeing unused kernel image (initmem) memory: 1024K
[    3.822727] Run /init as init process


Regards, Klaus

