From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 23 May 2024 08:57:23 +0200
Subject: [PATCH v6 06/20] dt-bindings: fsi: Document the FSI controller
 common properties
In-Reply-To: <20240522192524.3286237-7-eajames@linux.ibm.com>
References: <20240522192524.3286237-1-eajames@linux.ibm.com>
 <20240522192524.3286237-7-eajames@linux.ibm.com>
Message-ID: <c86add8e-8e6a-4dab-ba33-8c090371089d@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 22/05/2024 21:25, Eddie James wrote:
> Since there are multiple FSI controllers documented, the common
> properties should be documented separately and then referenced
> from the specific controller documentation. Add bus-frequency for
> the FSI bus and CFAM local bus frequencies. Add interrupt
> controller properties.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

