From: Joel Stanley <joel@jms.id.au>
Date: Thu, 11 Apr 2019 02:49:06 +0000
Subject: [PATCH 1/5] media: platform: Aspeed: Remove use of reset line
In-Reply-To: <1554229504-5661-2-git-send-email-eajames@linux.ibm.com>
References: <1554229504-5661-1-git-send-email-eajames@linux.ibm.com>
 <1554229504-5661-2-git-send-email-eajames@linux.ibm.com>
Message-ID: <CACPK8Xd7uYX+=T1Bwp37poFzGJODSHZigOaKhg_W5XzVnQ1mxA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2 Apr 2019 at 18:25, Eddie James <eajames@linux.ibm.com> wrote:
>
> The reset line is toggled by enabling the clocks, so it's not necessary
> to manually toggle the reset as well.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>
