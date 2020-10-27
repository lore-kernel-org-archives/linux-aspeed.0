From: Joel Stanley <joel@jms.id.au>
Date: Tue, 27 Oct 2020 02:18:41 +0000
Subject: [PATCH] net: ftgmac100: Fix missing TX-poll issue
In-Reply-To: <e6c8e96bb26a5505e967e697946d359c22ac68c5.camel@kernel.crashing.org>
References: <20201019073908.32262-1-dylan_hung@aspeedtech.com>
 <CACPK8Xfn+Gn0PHCfhX-vgLTA6e2=RT+D+fnLF67_1j1iwqh7yg@mail.gmail.com>
 <20201019120040.3152ea0b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <PS1PR0601MB1849166CBF6D1678E6E1210C9C1F0@PS1PR0601MB1849.apcprd06.prod.outlook.com>
 <CAK8P3a2pEfbLDWTppVHmGxXduOWPCwBw-8bMY9h3EbEecsVfTA@mail.gmail.com>
 <32bfb619bbb3cd6f52f9e5da205673702fed228f.camel@kernel.crashing.org>
 <529612e1-c6c4-4d33-91df-2a30bf2e1675@www.fastmail.com>
 <PS1PR0601MB18498469F0263306A6E5183F9C1A0@PS1PR0601MB1849.apcprd06.prod.outlook.com>
 <e6c8e96bb26a5505e967e697946d359c22ac68c5.camel@kernel.crashing.org>
Message-ID: <CACPK8XdPB0wnvuvwxO5BST7EzDuPqGcjHTkZm=7A0ZofzyXHag@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 26 Oct 2020 at 22:22, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Fri, 2020-10-23 at 13:08 +0000, Dylan Hung wrote:
> > The issue was found on our test chip (ast2600 version A0) which is
> > just for testing and won't be mass-produced.  This HW bug has been
> > fixed on ast2600 A1 and later versions.
> >
> > To verify the HW fix, I run overnight iperf and kvm tests on
> > ast2600A1 without this patch, and get stable result without hanging.
> > So I think we can discard this patch.
>
> This is great news. Thanks !

That is excellent news. I agree; we do not need fixes for A0 issues to
be kept in the mainline kernel. Thanks for updating us Dylan.

Cheers,

Joel
