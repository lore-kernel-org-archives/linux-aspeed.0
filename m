From: Asmaa Mnebhi <Asmaa@mellanox.com>
Date: Wed, 13 Nov 2019 17:52:56 +0000
Subject: [Openipmi-developer] [PATCH 2/2] drivers: ipmi: Modify max length
 of IPMB packet
In-Reply-To: <C9D94D1B-A992-425E-826F-3BDA98E26999@fb.com>
References: <20191112023610.3644314-1-vijaykhemka@fb.com>
 <20191112023610.3644314-2-vijaykhemka@fb.com>
 <20191112124845.GE2882@minyard.net>
 <7BC487D6-6ACA-46CE-A751-8367FEDEE647@fb.com>
 <20191112202932.GJ2882@minyard.net>
 <DB6PR0501MB27127CF534336BDEB5D005FFDA770@DB6PR0501MB2712.eurprd05.prod.outlook.com>
 <20191113005115.GK2882@minyard.net>
 <C9D94D1B-A992-425E-826F-3BDA98E26999@fb.com>
Message-ID: <DB6PR0501MB2712698C135A1195233A9E13DA760@DB6PR0501MB2712.eurprd05.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Vijay

-----Original Message-----
From: Vijay Khemka <vijaykhemka@fb.com> 
Sent: Wednesday, November 13, 2019 12:41 PM
To: minyard@acm.org; Asmaa Mnebhi <Asmaa@mellanox.com>
Cc: cminyard at mvista.com; Sai Dasari <sdasari@fb.com>; linux-aspeed at lists.ozlabs.org; Arnd Bergmann <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-kernel at vger.kernel.org; openipmi-developer at lists.sourceforge.net
Subject: Re: [Openipmi-developer] [PATCH 2/2] drivers: ipmi: Modify max length of IPMB packet



?On 11/12/19, 4:51 PM, "Corey Minyard" <tcminyard at gmail.com on behalf of minyard@acm.org> wrote:

    On Tue, Nov 12, 2019 at 10:06:00PM +0000, Asmaa Mnebhi wrote:
    > Also, let me clarify one thing. It doesn't matter how big the response is. In my testing, I also had some responses that are over 128 bytes, and this driver still works. It is the user space program which determines the last bytes received. The 128 bytes is the max number of bytes handled by your i2c/smbus driver at each i2c transaction. My i2c driver can only transmit 128 bytes at a time. So just like Corey pointed out, it would be better to pass this through ACPI/device tree.
    
    Yeah, I would really prefer device tree.  That's what it's designed for,
    really.  ioctls are not really what you want for this.  sysfs is a
    better choice as a backup for device tree (so you can change it if it's
    wrong).

Corey/Asmaa, 
Ok, I will pass this max size through device tree and change this patch. 
I have sent patch for i2c transfer using ioctl, I hope that should be fine. 
Please review that v2 patch.
    
>> why can't you pass this information through device tree/ACPI as well?
All you need in your DT/ACPI table is a variable that indicates whether it is i2c or smbus. You check that variable in the ipmb driver, then decide which code path to take.
I prefer not to use ioctl for system configuration.

    -corey
    
    > 
    > -----Original Message-----
    > From: Corey Minyard <tcminyard@gmail.com> On Behalf Of Corey Minyard
    > Sent: Tuesday, November 12, 2019 3:30 PM
    > To: Vijay Khemka <vijaykhemka@fb.com>
    > Cc: Arnd Bergmann <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>; openipmi-developer at lists.sourceforge.net; linux-kernel at vger.kernel.org; cminyard at mvista.com; Asmaa Mnebhi <Asmaa@mellanox.com>; joel at jms.id.au; linux-aspeed at lists.ozlabs.org; Sai Dasari <sdasari@fb.com>
    > Subject: Re: [PATCH 2/2] drivers: ipmi: Modify max length of IPMB packet
    > 
    > On Tue, Nov 12, 2019 at 07:56:34PM +0000, Vijay Khemka wrote:
    > > 
    > > 
    > > On 11/12/19, 4:48 AM, "Corey Minyard" <tcminyard at gmail.com on behalf of minyard@acm.org> wrote:
    > > 
    > >     On Mon, Nov 11, 2019 at 06:36:10PM -0800, Vijay Khemka wrote:
    > >     > As per IPMB specification, maximum packet size supported is 255,
    > >     > modified Max length to 240 from 128 to accommodate more data.
    > >     
    > >     I couldn't find this in the IPMB specification.
    > >     
    > >     IIRC, the maximum on I2C is 32 byts, and table 6-9 in the IPMI spec,
    > >     under "IPMB Output" states: The IPMB standard message length is
    > >     specified as 32 bytes, maximum, including slave address.
    > > 
    > > We are using IPMI OEM messages and our response size is around 150 
    > > bytes For some of responses. That's why I had set it to 240 bytes.
    > 
    > Hmm.  Well, that is a pretty significant violation of the spec, but there's nothing hard in the protocol that prohibits it, I guess.
    > 
    > If Asmaa is ok with this, I'm ok with it, too.
    > 
    > -corey
    > 
    > >     
    > >     I'm not sure where 128 came from, but maybe it should be reduced to 31.
    > >     
    > >     -corey
    > >     
    > >     > 
    > >     > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
    > >     > ---
    > >     >  drivers/char/ipmi/ipmb_dev_int.c | 2 +-
    > >     >  1 file changed, 1 insertion(+), 1 deletion(-)
    > >     > 
    > >     > diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
    > >     > index 2419b9a928b2..7f9198bbce96 100644
    > >     > --- a/drivers/char/ipmi/ipmb_dev_int.c
    > >     > +++ b/drivers/char/ipmi/ipmb_dev_int.c
    > >     > @@ -19,7 +19,7 @@
    > >     >  #include <linux/spinlock.h>
    > >     >  #include <linux/wait.h>
    > >     >  
    > >     > -#define MAX_MSG_LEN		128
    > >     > +#define MAX_MSG_LEN		240
    > >     >  #define IPMB_REQUEST_LEN_MIN	7
    > >     >  #define NETFN_RSP_BIT_MASK	0x4
    > >     >  #define REQUEST_QUEUE_MAX_LEN	256
    > >     > -- 
    > >     > 2.17.1
    > >     >
    > >     
    > > 
    > 
    > _______________________________________________
    > Openipmi-developer mailing list
    > Openipmi-developer at lists.sourceforge.net
    > https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.sourceforge.net_lists_listinfo_openipmi-2Ddeveloper&d=DwIDaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=v9MU0Ki9pWnTXCWwjHPVgpnCR80vXkkcrIaqU7USl5g&m=QFO5ClAjZ5KmfurkhkRpQQxx33h0Q3NZ9eFRbR3vGyk&s=mZUIyiVF1tBXO1v7ZhLWOW_BwIERBToytaV4ULjXhkM&e= 
    

