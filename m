From: Joel Stanley <joel@jms.id.au>
Date: Thu, 27 Sep 2018 07:20:07 +0400
Subject: [PATCH] net/ncsi: Add NCSI OEM command for FB Tiogapass
In-Reply-To: <5e9c8e3f8fd54845b15cd460efe9090d@AUSX13MPS306.AMER.DELL.COM>
References: <20180925000840.4111212-1-vijaykhemka@fb.com>
 <CACPK8XcDExGvCNBcFqOOP+1zQFFs6pMao+7rsZrJFqxPgcY+1Q@mail.gmail.com>
 <F570466E-4F6C-4AE1-91E0-0B4ECC193BE0@fb.com>
 <7cd8a49a057f1032e126b1e104fcf61e4956e06d.camel@mendozajonas.com>
 <FC2694E0-2F55-4089-8544-668243C6ECA2@fb.com>
 <MWHPR15MB14861AED8F8AF652CE5E62B3B2150@MWHPR15MB1486.namprd15.prod.outlook.com>
 <5e9c8e3f8fd54845b15cd460efe9090d@AUSX13MPS306.AMER.DELL.COM>
Message-ID: <CACPK8XfuXa19dGRqL+Ycdgh1LKmoQNuqGvtrrOgeNyvTZR01kQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 27 Sep 2018 at 00:39, <Justin.Lee1@dell.com> wrote:
>
> > >  As I understand Justin's version adds a generic handler, using the NCSI
> > >  Netlink interface to pass OEM commands and responses to and from
> > >  userspace, which does the actual packet handling.
> > Thanks for the direction Sam! Justin, if you don't mind, can you share the patches you have to add the support? This actually would solve a few other things we are trying to accomplish.
>
>
> Basically, I add a new flag to indicate the request is coming from the Netlink interface to allow the command handler and response handler to react.
> #define NCSI_REQ_FLAG_NETLINK_DRIVEN    2
>
> The work flow is as below.
>
> Request:
> User space application -> Netlink interface (msg) -> new Netlink handler - ncsi_send_cmd_nl() - ncsi_xmit_cmd()
>
> Response:
> Response received - ncsi_rcv_rsp() -> internal response handler - ncsi_rsp_handler_xxx() -> ncsi_send_netlink_rsp () -> Netlink interface (msg) -> user space application
> Command timeout - ncsi_request_timeout() -> ncsi_send_netlink_timeout () -> Netlink interface (msg with zero data length) -> user space application
>
> Error:
> Detected error -> ncsi_send_netlink_err () -> Netlink interface (err msg) -> user space application
>
> I will clean up some code and send out the patch.

Thanks for the overview. We look forward to your patches; please
include the same cc list as this series.

I think it makes sense to have some OEM NCSI handing purely in the
kenrel. This would allow eg. the MAC address of an interface to be
correct at boot, without requiring userspace to come up first.

I have also heard stories of temperature sensors over NCSI. Those
would make sense to be hwmon drivers, which again would mean handling
them in the kernel.

Justin, Vijay, can you please list the known NCSI OEM
commands/extensions that we plan on implementing?

Cheers,

Joel
