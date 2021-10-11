From: Joel Stanley <joel@jms.id.au>
Date: Mon, 11 Oct 2021 05:04:24 +0000
Subject: [PATCH v2] ARM: dts: aspeed: Add TYAN S7106 BMC machine
In-Reply-To: <CABoTLcTpZymAD0RNv9nHV8PeFniMWG=Yo9-csyn7hjdaTqoLUg@mail.gmail.com>
References: <20210909004920.1634322-1-osk@google.com>
 <CACPK8XdM62sratWi7nQ8xukE3CbsMSA7PK7nRH52aU7Niw3jWg@mail.gmail.com>
 <CACPK8XfRUdw3uHNoa+kOKWKAQcttj4nWyX=_Ue2eR0zCJ6fhHw@mail.gmail.com>
 <CABoTLcR=BH=eiY4wULsDd0QJ2NZusSYi57gWuX72wRDq8tvvHw@mail.gmail.com>
 <CACPK8Xe6UbZdB3854Wr_-m+sOE_xM0q5A+Kh=KnO1GvNBEtc4w@mail.gmail.com>
 <CABoTLcTpZymAD0RNv9nHV8PeFniMWG=Yo9-csyn7hjdaTqoLUg@mail.gmail.com>
Message-ID: <CACPK8XfMPhTDHjxS21K8+64skE5e5OSevt-i5V=KiRWmgKEAoQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 11 Oct 2021 at 01:33, Oskar Senft <osk@google.com> wrote:
>
> > It's now applied to the aspeed tree for v5.16.
> Thank you! Just in case and since I just looked for it for a bit: The
> "aspeed tree" now seems to be
> https://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git/.

Yes, I changed that a while back as I thought I'd start doing combined
aspeed and nuvoton pull requests. I haven't done a nuvoton one since
(no one using those devices seems to want to use them with upstream
kernels), so perhaps I could go back to using just the aspeed tree.
