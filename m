From: Vijay Khemka <vijaykhemka@fb.com>
Date: Tue, 21 Jan 2020 18:42:08 +0000
Subject: [GIT PULL] ARM: aspeed: devicetree changes for 5.6
In-Reply-To: <CACPK8XepSy6D4CNWjSWDDK0p7Dx_rneWne4t4uyy=di5nx3zmA@mail.gmail.com>
References: <CACPK8XepSy6D4CNWjSWDDK0p7Dx_rneWne4t4uyy=di5nx3zmA@mail.gmail.com>
Message-ID: <6958E763-F18E-4305-8480-2EB6C58A082C@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel,
I guess you missed my patch here.
  -- [PATCH v2] ARM: dts: aspeed: tiogapass: Add gpio line names

I have sent versionv2 on Jan 17 as v1 was not merged.

Regards
-Vijay

?On 1/19/20, 10:21 PM, "Linux-aspeed on behalf of Joel Stanley" <linux-aspeed-bounces+vijaykhemka=fb.com at lists.ozlabs.org on behalf of joel@jms.id.au> wrote:

    Hello ARM maintainers,
    
    Sorry for sending this one is a bit late, I was off at linux.conf.au last week.
    
    The following changes since commit 39be9e84f65be599919c7069bdad24dc2d9cd65d:
    
      ARM: dts: aspeed: rainier: Add UCD90320 power sequencer (2020-01-20
    15:50:57 +1000)
    
    are available in the Git repository at:
    
      git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
    tags/aspeed-5.6-devicetree
    
    for you to fetch changes up to 39be9e84f65be599919c7069bdad24dc2d9cd65d:
    
      ARM: dts: aspeed: rainier: Add UCD90320 power sequencer (2020-01-20
    15:50:57 +1000)
    
    ----------------------------------------------------------------
    ASPEED device tree updates for 5.6
    
     - Cleanups for dtc warnings
    
     - Ethernet hardware checksum cleanups. A bug in the driver was fixed so
     machines don't need to specify this anymore.
    
     - Misc improvements
    
    ----------------------------------------------------------------
    
    Andrew Jeffery (13):
          dt-bindings: pinctrl: aspeed: Add reg property as a hint
          dt-bindings: misc: Document reg for aspeed, p2a-ctrl nodes
          ARM: dts: aspeed-g5: Move EDAC node to APB
          ARM: dts: aspeed-g5: Use recommended generic node name for SDMC
          ARM: dts: vesnin: Add unit address for memory node
          ARM: dts: fp5280g2: Cleanup gpio-keys-polled properties
          ARM: dts: swift: Cleanup gpio-keys-polled properties
          ARM: dts: witherspoon: Cleanup gpio-keys-polled properties
          ARM: dts: aspeed: Cleanup lpc-ctrl and snoop regs
          ARM: dts: aspeed: Add reg hints to syscon children
          ARM: dts: aspeed-g5: Sort LPC child nodes by unit address
          ARM: dts: aspeed-g6: Cleanup watchdog unit address
          ARM: dts: ibm-power9-dual: Add a unit address for OCC nodes
    
    Eddie James (1):
          ARM: dts: aspeed: rainier: Switch PSUs to unknown version
    
    Ivan Mikhaylov (1):
          ARM: dts: aspeed: Add SD card for Vesnin
    
    Jim Wright (1):
          ARM: dts: aspeed: rainier: Add UCD90320 power sequencer
    
    Joel Stanley (1):
          ARM: dts: aspeed: AST2400 disables hw checksum
    
    Tao Ren (2):
          ARM: dts: aspeed: netbmc: Delete no-hw-checksum
          ARM: dts: aspeed: yamp: Delete no-hw-checksum
    

