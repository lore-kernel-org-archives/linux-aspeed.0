From: Corey Minyard <minyard@acm.org>
Date: Tue, 12 Nov 2019 14:29:32 -0600
Subject: [PATCH 2/2] drivers: ipmi: Modify max length of IPMB packet
In-Reply-To: <7BC487D6-6ACA-46CE-A751-8367FEDEE647@fb.com>
References: <20191112023610.3644314-1-vijaykhemka@fb.com>
 <20191112023610.3644314-2-vijaykhemka@fb.com>
 <20191112124845.GE2882@minyard.net>
 <7BC487D6-6ACA-46CE-A751-8367FEDEE647@fb.com>
Message-ID: <20191112202932.GJ2882@minyard.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Nov 12, 2019 at 07:56:34PM +0000, Vijay Khemka wrote:
> 
> 
> ?On 11/12/19, 4:48 AM, "Corey Minyard" <tcminyard at gmail.com on behalf of minyard@acm.org> wrote:
> 
>     On Mon, Nov 11, 2019 at 06:36:10PM -0800, Vijay Khemka wrote:
>     > As per IPMB specification, maximum packet size supported is 255,
>     > modified Max length to 240 from 128 to accommodate more data.
>     
>     I couldn't find this in the IPMB specification.
>     
>     IIRC, the maximum on I2C is 32 byts, and table 6-9 in the IPMI spec,
>     under "IPMB Output" states: The IPMB standard message length is
>     specified as 32 bytes, maximum, including slave address.
> 
> We are using IPMI OEM messages and our response size is around 150 bytes
> For some of responses. That's why I had set it to 240 bytes.

Hmm.  Well, that is a pretty significant violation of the spec, but
there's nothing hard in the protocol that prohibits it, I guess.

If Asmaa is ok with this, I'm ok with it, too.

-corey

>     
>     I'm not sure where 128 came from, but maybe it should be reduced to 31.
>     
>     -corey
>     
>     > 
>     > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
>     > ---
>     >  drivers/char/ipmi/ipmb_dev_int.c | 2 +-
>     >  1 file changed, 1 insertion(+), 1 deletion(-)
>     > 
>     > diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
>     > index 2419b9a928b2..7f9198bbce96 100644
>     > --- a/drivers/char/ipmi/ipmb_dev_int.c
>     > +++ b/drivers/char/ipmi/ipmb_dev_int.c
>     > @@ -19,7 +19,7 @@
>     >  #include <linux/spinlock.h>
>     >  #include <linux/wait.h>
>     >  
>     > -#define MAX_MSG_LEN		128
>     > +#define MAX_MSG_LEN		240
>     >  #define IPMB_REQUEST_LEN_MIN	7
>     >  #define NETFN_RSP_BIT_MASK	0x4
>     >  #define REQUEST_QUEUE_MAX_LEN	256
>     > -- 
>     > 2.17.1
>     > 
>     
> 
