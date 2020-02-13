From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 13 Feb 2020 11:24:36 +1030
Subject: [PATCH v3] ARM: dts: aspeed: witherspoon: Add gpio line names
In-Reply-To: <CACPK8Xdg0ocBzDqtkoo8cSCpUq+QjHQ1PKrsVZd8NPUvPFeFCw@mail.gmail.com>
References: <20200206170234.84288-1-geissonator@gmail.com>
 <CACPK8Xdg0ocBzDqtkoo8cSCpUq+QjHQ1PKrsVZd8NPUvPFeFCw@mail.gmail.com>
Message-ID: <288ba2d7-77dc-40a7-90e8-f2781b3fe067@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Mon, 10 Feb 2020, at 12:59, Joel Stanley wrote:
> On Thu, 6 Feb 2020 at 17:03, Andrew Geissler <geissonator@gmail.com> wrote:
> >
> > From: Andrew Geissler <geissonator@yahoo.com>
> >
> > Name the GPIOs to help userspace work with them. The names describe the
> > functionality the lines provide, not the net or ball name. This makes it
> > easier to share userspace code across different systems and makes the
> > use of the lines more obvious.
> >
> > Signed-off-by: Andrew Geissler <geissonator@yahoo.com>
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> I will wait for  Andrew before merging, but this looks good to me.

To the best of my knowledge this is the only supported approach.

I haven't checked the mapping of gpio lines to functions, but for
the concept:

Acked-by: Andrew Jeffery <andrew@aj.id.au>

Andrew
