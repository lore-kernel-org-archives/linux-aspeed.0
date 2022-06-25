From: Dhananjay Phadke <dphadke@linux.microsoft.com>
Date: Fri, 24 Jun 2022 20:28:39 -0700
Subject: [PATCH v4 0/5] Add Aspeed crypto driver for hardware acceleration
In-Reply-To: <20220624090827.3909179-1-neal_liu@aspeedtech.com>
References: <20220624090827.3909179-1-neal_liu@aspeedtech.com>
Message-ID: <3dde4d8e-5f97-dc07-1763-981942d23f12@linux.microsoft.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Neal,

On 6/24/2022 2:08 AM, Neal Liu wrote:
> Aspeed Hash and Crypto Engine (HACE) is designed to accelerate the
> throughput of hash data digest, encryption and decryption.
> 
> These patches aim to add Aspeed hash & crypto driver support.
> The hash & crypto driver also pass the run-time self tests that
> take place at algorithm registration.
> 
> Tested-by below configs:
> - CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
> - CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
> - CONFIG_DMA_API_DEBUG=y
> - CONFIG_DMA_API_DEBUG_SG=y
> - CONFIG_CPU_BIG_ENDIAN=y
> 
> Change since v3:
> - Use dmam_alloc_coherent() instead to manage dma_alloc_coherent().
> - Add more error handler of dma_prepare() & crypto_engine_start().
> 
> Change since v2:
> - Fix endianness issue. Tested on both little endian & big endian
>    system.
> - Use common crypto hardware engine for enqueue & dequeue requests.
> - Use pre-defined IVs for SHA-family.
> - Revise error handler flow.
> - Fix sorts of coding style problems.
> 
> Change since v1:
> - Add more error handlers, including DMA memory allocate/free, DMA
>    map/unmap, clock enable/disable, etc.
> - Fix check dma_map error for config DMA_API_DEBUG.
> - Fix dt-binding doc & dts node naming.
> 
> 
> Neal Liu (5):
>    crypto: aspeed: Add HACE hash driver
>    dt-bindings: clock: Add AST2600 HACE reset definition
>    ARM: dts: aspeed: Add HACE device controller node
>    dt-bindings: crypto: add documentation for aspeed hace
>    crypto: aspeed: add HACE crypto driver

The driver claims compatible with aspeed,ast2500-hace, but there's no
equivalent g5 DTS change (patch 3/5) or reset definition (patch 2/5) in
aspeed-clock.h? Either drop ast2500 compatible from this patch series or 
fix these.

Thanks,
Dhananjay
