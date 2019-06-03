From: Adriana Kobylak <anoo@linux.ibm.com>
Date: Mon, 03 Jun 2019 14:38:10 -0500
Subject: [PATCH dev-5.1] ARM: dts: aspeed: swift: Add VDD (IR35219) devices
In-Reply-To: <CACPK8Xc8_SAkxQ1_HTFOkCsV8ejWS=MVXazH+bvDcE=9xKLF8A@mail.gmail.com>
References: <1559334700-51970-1-git-send-email-anoo@linux.ibm.com>
 <CACPK8Xc8_SAkxQ1_HTFOkCsV8ejWS=MVXazH+bvDcE=9xKLF8A@mail.gmail.com>
Message-ID: <66ef1d874db0bf4963f3ea80d3436c3f@linux.vnet.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2019-06-03 04:06, Joel Stanley wrote:
> On Fri, 31 May 2019 at 20:31, Adriana Kobylak <anoo@linux.ibm.com> 
> wrote:
>> 
>> From: Adriana Kobylak <anoo@us.ibm.com>
>> 
>> Add the VDD (IR35219) devices to the Swift device tree.
>> 
>> +       ir35219 at 70 {
>> +               compatible = "infineon,ir35219";
> 
> There's no driver for these in our tree. Do you have one coming?

Eddie will be writing one [Swift VDD VRM device driver 
#311](https://github.com/ibm-openbmc/dev/issues/311)
Should we put this patch on hold until the driver is done?

