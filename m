From: Florian Fainelli <f.fainelli@gmail.com>
Date: Thu, 12 Jan 2023 13:13:51 -0800
Subject: [PATCH net-next 03/10] net: mdio: mux-bcm-iproc: Separate C22 and
 C45 transactions
In-Reply-To: <20230112-net-next-c45-seperation-part-2-v1-3-5eeaae931526@walle.cc>
References: <20230112-net-next-c45-seperation-part-2-v1-0-5eeaae931526@walle.cc>
 <20230112-net-next-c45-seperation-part-2-v1-3-5eeaae931526@walle.cc>
Message-ID: <2fd5c783-94f1-1896-c6b9-431a754aec14@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 1/12/23 07:15, Michael Walle wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> The MDIO mux broadcom iproc can perform both C22 and C45 transfers.
> Create separate functions for each and register the C45 versions using
> the new API calls.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> Apparently, in the c45 case, the reg value including the MII_ADDR_C45
> bit is written to the hardware. Looks weird, that a "random" software
> bit is written to a register. Florian is that correct? Also, with this
> patch this flag isn't set anymore.

We should be masking the MII_ADDR_C45 bit because the MDIO_ADDR_OFFSET 
only defines bits 0 through 20 as being read/write and bits above being 
read-only. In practice, this is probably not making any difference or harm.
-- 
Florian

