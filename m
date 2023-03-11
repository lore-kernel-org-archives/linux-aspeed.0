From: Klaus Kudielka <klaus.kudielka@gmail.com>
Date: Sat, 11 Mar 2023 07:49:23 +0100
Subject: [PATCH net-next v2 4/6] net: mdio: scan bus based on bus
 capabilities for C22 and C45
In-Reply-To: <4abd56aa-5b9f-4e16-b0ca-11989bb8c764@lunn.ch>
References: <20230116-net-next-remove-probe-capabilities-v2-4-15513b05e1f4@walle.cc>
	 <449bde236c08d5ab5e54abd73b645d8b29955894.camel@gmail.com>
	 <100c439a-2a4d-4cb2-96f2-5bf273e2121a@lunn.ch>
	 <712bc92ca6d576f33f63f1e9c2edf0030b10d3ae.camel@gmail.com>
	 <db6b8a09-b680-4baa-8963-d355ad29eb09@lunn.ch>
	 <0e10aa8492eadb587949d8744b56fccaabbd183b.camel@gmail.com>
	 <72530e86-9ba9-4a01-9cd2-68835ecae7a0@lunn.ch>
	 <09d65e1ee0679e1e74b4f3a5a4c55bd48332f043.camel@gmail.com>
	 <70f5bca0-322c-4bae-b880-742e56365abe@lunn.ch>
	 <10da10caea22a8f5da8f1779df3e13b948e8a363.camel@gmail.com>
	 <4abd56aa-5b9f-4e16-b0ca-11989bb8c764@lunn.ch>
Message-ID: <bff0e542b8c04980e9e3af1d3e6bf739c87eb514.camel@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, 2023-03-11 at 00:49 +0100, Andrew Lunn wrote:
> > Yes, that helps. Primarily, because mdiobus_scan_bus_c45 now is called only once,
> > and at least some things are done in parallel.
> 
> Great. Could you cook up a proper patch and submit it?

I can give it a try. The commit message will be from my perspective,
and the change Suggested-By you.

Best regards, Klaus
