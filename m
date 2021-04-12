From: Joel Stanley <joel@jms.id.au>
Date: Mon, 12 Apr 2021 02:20:59 +0000
Subject: [PATCH v3] ARM: dts: aspeed: add ASRock E3C246D4I BMC
In-Reply-To: <84202973-1a94-4630-beeb-f33d044a0364@www.fastmail.com>
References: <20210401044232.9637-1-zev@bewilderbeest.net>
 <84202973-1a94-4630-beeb-f33d044a0364@www.fastmail.com>
Message-ID: <CACPK8XcfuEyqGmO72taXFPARxwzLyct5__0C0CF-nyEf6Yubnw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 12 Apr 2021 at 02:16, Andrew Jeffery <andrew@aj.id.au> wrote:
> On Thu, 1 Apr 2021, at 15:12, Zev Weiss wrote:

> > +&vuart {
> > +     status = "okay";
> > +     aspeed,sirq-active-high;
>
> This should probably go away, but otherwise,

Zev, this has already been merged (both to mainline for v5.13 and in
openbmc), so any fixups need to come as patches on top of the existing
code.

Cheers,

Joel
