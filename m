From: Benjamin Fair <benjaminfair@google.com>
Date: Tue, 10 Jul 2018 11:11:55 -0700
Subject: [PATCH] drivers/misc: Aspeed LPC snoop output using misc chardev
In-Reply-To: <20180709075233.GF13479@kroah.com>
References: <20180706182531.137362-1-benjaminfair@google.com>
 <20180709075233.GF13479@kroah.com>
Message-ID: <CADKL2t5vaRPYDr0FqpYdZF_7z+Uc1HAxPdZGjK7JcaYyu=tLSg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jul 9, 2018 at 12:52 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jul 06, 2018 at 11:25:32AM -0700, Benjamin Fair wrote:
> > From: Robert Lippert <rlippert@google.com>
> >
> > Provides the data bytes snooped over the LPC snoop bus to userspace
> > as a (blocking) misc character device.
>
> If this is a debugging thing, why not just use debugfs instead of a char
> device?  That should make this code simpler overall, and you can do
> whatever you want with debugfs.
>
> thanks,
>
> greg k-h

This interface will primarily be used by a userspace daemon which will poll the
file for changes. The debugging usage in the commit message is for verifying
that the driver is working properly.

I'll update the commit message to make this more clear.

Thanks,
Benjamin
