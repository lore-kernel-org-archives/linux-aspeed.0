From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 25 Aug 2022 14:35:31 +0200
Subject: [PATCH v3 2/2] ARM: dts: aspeed: Add device tree for Ampere's Mt.
 Mitchell BMC
In-Reply-To: <673e200f-f458-7866-f956-3d5bd7160a49@os.amperecomputing.com>
References: <20220817071539.176110-1-quan@os.amperecomputing.com>
 <20220817071539.176110-3-quan@os.amperecomputing.com> <CACPK8XdDpG3ONM1=-E6qvHL1FgMNWSMPoL_sVGJK6BmmnT3w_w@mail.gmail.com>
 <CAK8P3a2LZKfZpdTQ-R4o9mJ6dk52VRF+Bxj=PJEx-1MA4yH8+w@mail.gmail.com> <673e200f-f458-7866-f956-3d5bd7160a49@os.amperecomputing.com>
Message-ID: <CAK8P3a3MU7shuBpcpRNC5L6xxQmSy8FXCX1jvYXhv-NT3PMYOw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Aug 23, 2022 at 10:27 AM Quan Nguyen
<quan@os.amperecomputing.com> wrote:
> On 18/08/2022 19:06, Arnd Bergmann wrote:
>
> Thanks Arnd for the comment.
>
> I think adding -append could solve the issue.
>
> But as the bootargs still exist in all other
> arch/arm/boot/dts/aspeed-bmc-*.dts should we still keep bootargs for
> this dts?

I think it should still be removed. Only 238 of 2547 set the console using
bootargs, so that would make it more consistent with the other files.

Changing the files that have the same issue is a separate matter.

      Arnd
