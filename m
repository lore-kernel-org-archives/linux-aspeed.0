From: Tao Ren <taoren@fb.com>
Date: Fri, 7 Dec 2018 01:13:04 +0000
Subject: [PATCH v2] clocksource/drivers/fttmr010: fix invalid interrupt
 register access
In-Reply-To: <7284BEA6-FAE9-4293-94E0-FC29304AA36D@fb.com>
References: <20181003215350.3550926-1-taoren@fb.com>
 <CACRpkdbbUO9_VOtnZL+Xf_0nTTgSruaaPOLnvZ4M+NQfPLzvWQ@mail.gmail.com>
 <BC1ADE3F-F31F-4E1E-A6EE-3BD83C5F2634@fb.com>
 <279e6a06-3f2f-e736-f28e-4d099729a517@linaro.org>
 <7284BEA6-FAE9-4293-94E0-FC29304AA36D@fb.com>
Message-ID: <48A12A26-5AF0-483C-85D4-428F00038D7A@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 11/5/18, 11:00 AM, "Tao Ren" <taoren@fb.com> wrote:

> On 11/5/18, 10:51 AM, "Daniel Lezcano" <daniel.lezcano@linaro.org> wrote:
>> Oh right, sorry. Should it go to stable also ? Is there a Fixes tag it can apply ?
>>
> Personally I don't think it needs to go to stable, because I don't see any functional failures caused by this invalid register access.

Hi Daniel,

Not sure if I missed any emails from you, but looks like the patch is not included in your tree? Are we planning to include the patch in 4.21 merge window?

Thanks,

Tao Ren

