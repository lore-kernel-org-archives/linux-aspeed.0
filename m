From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 04 Sep 2023 08:00:34 +0000
Subject: [RFT PATCH 5/6] drm: Call drm_atomic_helper_shutdown() at
 shutdown/remove time for misc drivers
In-Reply-To: <20230901163944.RFT.5.I771eb4bd03d8772b19e7dcfaef3e2c167bce5846@changeid>
References: <20230901163944.RFT.5.I771eb4bd03d8772b19e7dcfaef3e2c167bce5846@changeid>
Message-ID: <1506b6324d05084097f1971520d76fa0.mripard@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 1 Sep 2023 16:39:56 -0700, Douglas Anderson wrote:
> Based on grepping through the source code these drivers appear to be
> missing a call to drm_atomic_helper_shutdown() at system shutdown time
> and at driver remove (or unbind) time. Among other things, this means
> that if a panel is in use that it won't be cleanly powered off at
> system shutdown time.
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
