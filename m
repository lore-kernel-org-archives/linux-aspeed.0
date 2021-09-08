From: Paul Fertser <fercerpav@gmail.com>
Date: Wed, 8 Sep 2021 14:27:04 +0300
Subject: VUART compatibility (was: Re: [PATCH v2 0/3] arm: aspeed: Add
 UART routing support)
In-Reply-To: <20210908105245.GB23326@home.paul.comp>
References: <20210902021817.17506-1-chiawei_wang@aspeedtech.com>
 <20210908094248.GZ23326@home.paul.comp>
 <HK0PR06MB3779180F75DB8BD872F8A78391D49@HK0PR06MB3779.apcprd06.prod.outlook.com>
 <20210908105245.GB23326@home.paul.comp>
Message-ID: <20210908112703.GC23326@home.paul.comp>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 08, 2021 at 01:52:45PM +0300, Paul Fertser wrote:
> In this case do we have some way to make it an obvious error to enable
> both SUART1 and VUART in DTS? If they're conflicting surely there
> should be a way to express that?

I have to add this idea is obviously silly as we have sysfs nodes to
specify both LPC I/O address and interrupt number for VUART and
arbitrary numbers are allowed (so it can conflict with any of the
SUART port) so there should be probably some runtime checking in VUART
driver to prevent that?

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav at gmail.com
