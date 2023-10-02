From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 2 Oct 2023 15:30:11 -0700
Subject: [PATCH v2 3/3] mctp: Add MCTP-over-KCS transport binding
In-Reply-To: <20231002143441.545-4-aladyshev22@gmail.com>
References: <20231002143441.545-1-aladyshev22@gmail.com>
	<20231002143441.545-4-aladyshev22@gmail.com>
Message-ID: <20231002153011.5444fd83@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon,  2 Oct 2023 17:34:41 +0300 Konstantin Aladyshev wrote:
> This change adds a MCTP KCS transport binding, as defined by the DMTF
> specificiation DSP0254 - "MCTP KCS Transport Binding".
> A MCTP protocol network device is created for each KCS channel found in
> the system.
> The interrupt code for the KCS state machine is based on the current
> IPMI KCS driver.

Still doesn't build, please make sure W=1 C=1 build is clean with both
GCC and Clang (you can point them at a specific path to avoid building
the entire kernel with the warnings enabled).
-- 
pw-bot: cr
