From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 7 Jun 2021 12:50:07 -0700
Subject: [RFC PATCH 3/3] i2c: aspeed: allow 255 byte block transfers
In-Reply-To: <20210602044113.1581347-4-matt@codeconstruct.com.au>
References: <20210602044113.1581347-1-matt@codeconstruct.com.au>
 <20210602044113.1581347-4-matt@codeconstruct.com.au>
Message-ID: <CAFd5g44Hd8LbSPCs4CT=KAh-Z5jwuc9y62yVh-azbc8OU+p56A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 1, 2021 at 9:42 PM Matt Johnston <matt@codeconstruct.com.au> wrote:
>
> Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>

Looks good to me. I have attempted much larger transfers than 255
bytes in non-SMBus mode so this should work fine.

Excited to see some of SMBus v3 support being added!

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
