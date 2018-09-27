From: Justin.Lee1@Dell.com <Justin.Lee1@Dell.com>
Date: Thu, 27 Sep 2018 17:46:32 +0000
Subject: [PATCH] net/ncsi: Add NCSI OEM command for FB Tiogapass
In-Reply-To: <CACPK8XfuXa19dGRqL+Ycdgh1LKmoQNuqGvtrrOgeNyvTZR01kQ@mail.gmail.com>
References: <20180925000840.4111212-1-vijaykhemka@fb.com>
 <CACPK8XcDExGvCNBcFqOOP+1zQFFs6pMao+7rsZrJFqxPgcY+1Q@mail.gmail.com>
 <F570466E-4F6C-4AE1-91E0-0B4ECC193BE0@fb.com>
 <7cd8a49a057f1032e126b1e104fcf61e4956e06d.camel@mendozajonas.com>
 <FC2694E0-2F55-4089-8544-668243C6ECA2@fb.com>
 <MWHPR15MB14861AED8F8AF652CE5E62B3B2150@MWHPR15MB1486.namprd15.prod.outlook.com>
 <5e9c8e3f8fd54845b15cd460efe9090d@AUSX13MPS306.AMER.DELL.COM>
 <CACPK8XfuXa19dGRqL+Ycdgh1LKmoQNuqGvtrrOgeNyvTZR01kQ@mail.gmail.com>
Message-ID: <9553a4168a7e4134a3d6d7e2572bace0@AUSX13MPS306.AMER.DELL.COM>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


> Thanks for the overview. We look forward to your patches; please
> include the same cc list as this series.

> I think it makes sense to have some OEM NCSI handing purely in the
> kenrel. This would allow eg. the MAC address of an interface to be
> correct at boot, without requiring userspace to come up first.

> I have also heard stories of temperature sensors over NCSI. Those
> would make sense to be hwmon drivers, which again would mean handling
> them in the kernel.

> Justin, Vijay, can you please list the known NCSI OEM
> commands/extensions that we plan on implementing?

In our implementation, All OEM commands are transparent to Kernel.
We don't plan to add any specific handler in the Kernel. 

Thanks,
Justin
