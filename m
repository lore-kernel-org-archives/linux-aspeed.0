From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 9 Jun 2021 11:17:22 +0200
Subject: [PATCH v3 1/5] dt-bindings: aspeed-sgpio: Convert txt bindings to
 yaml.
In-Reply-To: <20210604033039.GC25112@aspeedtech.com>
References: <20210603101822.9645-1-steven_lee@aspeedtech.com>
 <20210603101822.9645-2-steven_lee@aspeedtech.com>
 <516bb11a-b75f-49e1-ba79-e5a4c344a7ab@www.fastmail.com>
 <20210604033039.GC25112@aspeedtech.com>
Message-ID: <CACRpkdawakx66Nix41h=FzhL--QEMZCcDX=a_hf_kTq+0DjpAg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jun 4, 2021 at 5:31 AM Steven Lee <steven_lee@aspeedtech.com> wrote:

> However, it might affect users who update kernel/driver from the
> old kernel/driver as they may expect the gpio output pin base is start
> from 80(MAX_NR_HW_SGPIO).

Why? What users? In-kernel, out-of-tree-kernel or userspace users?

In-kernel users can be fixed, out-of-tree kernels we don't care about
and userspace should be using the character device.

Just change it.

Yours,
Linus Walleij
