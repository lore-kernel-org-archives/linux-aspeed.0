From: Neal Liu <neal_liu@aspeedtech.com>
Date: Fri, 28 Oct 2022 09:55:57 +0000
Subject: [PATCH] usb: gadget: aspeed: fix buffer overflow
In-Reply-To: <Y1ueEYJk2epT/g4J@kroah.com>
References: <20221024094853.2877441-1-yulei.sh@bytedance.com>
 <HK0PR06MB32022348EA65805C7109B7D080329@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <CAGm54UExHOBw61DJNqxvW67OSr60fQ+Q247t63RzymiMOmHmFg@mail.gmail.com>
 <HK0PR06MB320203EF8E3AD14C34359B0580329@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <Y1ueEYJk2epT/g4J@kroah.com>
Message-ID: <HK0PR06MB32024F58191E17DC5ABC99F380329@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> > > > Thanks for your feedback.
> > > > I tried to reproduce it on my side, and it cannot be reproduce it.
> > > > Here are my test sequences:
> > > > 1. emulate one of the vhub port to usb ethernet through Linux
> > > > gadget
> > > > (ncm)
> > >
> > > We are using rndis instead of ncm.
> > >
> > > > 2. connect BMC vhub to Host
> > > > 3. BMC & Host can ping each other (both usb eth dev default mtu is
> > > > 1500) 4. Set BMC mtu to 1000 (Host OS cannot set usb eth dev mtu
> > > > to 2000, it's maxmtu is 1500)
> > >
> > > Not sure if it's related, but in my case (USB rndis, Debian 10 OS)
> > > it should be able to set MTU to 2000.
> >
> > Using rndis is able to set MTU to 2000, and the issue can be reproduced.
> 
> Please NEVER use rndis anymore.  I need to go just delete that driver from
> the tree.
> 
> It is insecure-by-design and will cause any system that runs it to be instantly
> compromised and it can not be fixed.  Never trust it.
> 
> Even for data throughput tests, I wouldn't trust it as it does odd things with
> packet sizes as you show here.

Thanks for the info, Greg.
If rndis will no longer be supported, how to use usb-ethernet on Windows OS?
For my understanding, ncm/ecm cannot work on Windows OS.
