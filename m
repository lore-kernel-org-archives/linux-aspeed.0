From: Tao Ren <taoren@fb.com>
Date: Mon, 5 Nov 2018 19:00:06 +0000
Subject: [PATCH v2] clocksource/drivers/fttmr010: fix invalid interrupt
 register access
In-Reply-To: <279e6a06-3f2f-e736-f28e-4d099729a517@linaro.org>
References: <20181003215350.3550926-1-taoren@fb.com>
 <CACRpkdbbUO9_VOtnZL+Xf_0nTTgSruaaPOLnvZ4M+NQfPLzvWQ@mail.gmail.com>
 <BC1ADE3F-F31F-4E1E-A6EE-3BD83C5F2634@fb.com>
 <279e6a06-3f2f-e736-f28e-4d099729a517@linaro.org>
Message-ID: <7284BEA6-FAE9-4293-94E0-FC29304AA36D@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 11/5/18, 10:51 AM, "Daniel Lezcano" <daniel.lezcano@linaro.org> wrote:

> Oh right, sorry. Should it go to stable also ? Is there a Fixes tag it can apply ?

Personally I don't think it needs to go to stable, because I don't see any functional failures caused by this invalid register access.

Thanks,
Tao Ren

