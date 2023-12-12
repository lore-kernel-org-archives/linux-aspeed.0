From: Joel Stanley <joel@jms.id.au>
Date: Tue, 12 Dec 2023 13:09:56 +1030
Subject: [PATCH v4 0/2] i2c: aspeed: Late ack Tx done irqs and handle
 coalesced start with stop conditions
In-Reply-To: <20231211102217.2436294-1-quan@os.amperecomputing.com>
References: <20231211102217.2436294-1-quan@os.amperecomputing.com>
Message-ID: <CACPK8Xc6-M9fsx3AUPobzvG6sjCrr8Sj5B3Q4Onp5wGvMm_BrA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 at 20:52, Quan Nguyen <quan@os.amperecomputing.com> wrote:
>
> This series consists of two patches to handle the below issues observed
> when testing with slave mode:
>   + The coalesced stop condition with the start conditions
>   + Early ack'ed of Tx done (ACK and NAK) causing "Unexpected Ack on
>   read request".

Looks good. I've reached out to a few people who use slave mode to ask
for review and testing on hardware. As long as they don't come back
with issues, we should get this merged and backported to stable.

Reviewed-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel
