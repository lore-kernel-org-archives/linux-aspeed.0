From: Joel Stanley <joel@jms.id.au>
Date: Mon, 11 Oct 2021 04:57:09 +0000
Subject: [PATCH v2] ARM: dts: aspeed: Add TYAN S7106 BMC machine
In-Reply-To: <CABoTLcTA0aLN2=+vYG2fyP=VE-mGKe3bZK9L_+XtJ4C3Rg9Abw@mail.gmail.com>
References: <20210909004920.1634322-1-osk@google.com>
 <CACPK8XdM62sratWi7nQ8xukE3CbsMSA7PK7nRH52aU7Niw3jWg@mail.gmail.com>
 <CACPK8XfRUdw3uHNoa+kOKWKAQcttj4nWyX=_Ue2eR0zCJ6fhHw@mail.gmail.com>
 <CABoTLcR=BH=eiY4wULsDd0QJ2NZusSYi57gWuX72wRDq8tvvHw@mail.gmail.com>
 <CACPK8Xe6UbZdB3854Wr_-m+sOE_xM0q5A+Kh=KnO1GvNBEtc4w@mail.gmail.com>
 <CABoTLcTA0aLN2=+vYG2fyP=VE-mGKe3bZK9L_+XtJ4C3Rg9Abw@mail.gmail.com>
Message-ID: <CACPK8XegMW2FoBs8X4at+aSm42vqyp5KFAUW+Yfp6So-x7uYDw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 8 Oct 2021 at 12:30, Oskar Senft <osk@google.com> wrote:
>
> Hi Joel
>
> > It's now applied to the aspeed tree for v5.16. I made one small fix to
> > the makefile, where we expect .dtb but you added .dts.
> Argh, I'm sorry for that! Did I miss to run a test that would have
> complained about this?

Unfortunately it fails silently.

You could have cleaned your object tree and checked that the dts was
built into a dtb when running "make" (ie, the default rule without
specifying what to build).
