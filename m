From: Al Viro <viro@zeniv.linux.org.uk>
Date: Thu, 22 Apr 2021 09:26:27 +0000
Subject: [PATCH] soc: aspeed: fix a ternary sign expansion bug
In-Reply-To: <YIFA68mfUTSMczp0@zeniv-ca.linux.org.uk>
References: <YIE90PSXsMTa2Y8n@mwanda> <YIFA68mfUTSMczp0@zeniv-ca.linux.org.uk>
Message-ID: <YIFBQ50rcZO3NDFD@zeniv-ca.linux.org.uk>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 22, 2021 at 09:24:59AM +0000, Al Viro wrote:
> On Thu, Apr 22, 2021 at 12:11:44PM +0300, Dan Carpenter wrote:
> > The intent here was to return negative error codes but it actually
> > returns positive values.  The problem is that type promotion with
> > ternary operations is quite complicated.
> > 
> > "ret" is an int.  "copied" is a u32.  And the snoop_file_read() function
> > returns long.  What happens is that "ret" is cast to u32 and becomes
> > positive then it's cast to long and it's still positive.
> > 
> > Fix this by removing the ternary so that "ret" is type promoted directly
> > to long.
> 
> Hmm...  Let's grep for kfifo_to_user() - smells like a possible recurring bug...
> Yup -
> 
> samples/kfifo/bytestream-example.c:138: ret = kfifo_to_user(&test, buf, count, &copied);
> samples/kfifo/inttype-example.c:131:    ret = kfifo_to_user(&test, buf, count, &copied);
> samples/kfifo/record-example.c:145:     ret = kfifo_to_user(&test, buf, count, &copied);
> 
> All three are exactly like that one.

Nevermind, you've already caught and posted that bunch.  Sorry for noise...
