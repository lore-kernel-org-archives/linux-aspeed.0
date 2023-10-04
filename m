From: Simon Horman <horms@kernel.org>
Date: Wed, 4 Oct 2023 14:27:33 +0200
Subject: [PATCH v3 3/3] mctp: Add MCTP-over-KCS transport binding
In-Reply-To: <20231003131505.337-4-aladyshev22@gmail.com>
References: <20231003131505.337-1-aladyshev22@gmail.com>
 <20231003131505.337-4-aladyshev22@gmail.com>
Message-ID: <ZR1aNb0+D+uO+Qm8@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 03, 2023 at 04:15:05PM +0300, Konstantin Aladyshev wrote:
> This change adds a MCTP KCS transport binding, as defined by the DMTF
> specificiation DSP0254 - "MCTP KCS Transport Binding".
> A MCTP protocol network device is created for each KCS channel found in
> the system.
> The interrupt code for the KCS state machine is based on the current
> IPMI KCS driver.
> 
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>

...

> diff --git a/drivers/net/mctp/mctp-kcs.c b/drivers/net/mctp/mctp-kcs.c

...

> +static inline void set_state(struct mctp_kcs *mkcs, u8 state)

Hi Konstantin,

Please avoid the inline keyword in C files unless there is a demonstrable
reason to use it. In general, the compiler should be left to decide.

> +{
> +	dev_dbg(mkcs->client.dev->dev, "%s: state=0x%02x", __func__, state);
> +	kcs_bmc_update_status(mkcs->client.dev, KCS_STATUS_STATE_MASK,
> +			      KCS_STATUS_STATE(state));
> +}

...

> +static inline struct mctp_kcs *client_to_mctp_kcs(struct kcs_bmc_client *client)

Ditto.

> +{
> +	return container_of(client, struct mctp_kcs, client);
> +}

...
