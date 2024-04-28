From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 28 Apr 2024 18:43:04 +0200
Subject: [PATCH v3 09/14] dt-bindings: fsi: Document the FSI Hub
 Controller
In-Reply-To: <8d5cca29-2b4d-40a7-a7dd-c3eff625af95@linux.ibm.com>
References: <20240425213701.655540-1-eajames@linux.ibm.com>
 <20240425213701.655540-10-eajames@linux.ibm.com>
 <91d5683b-17a2-466c-ab3d-baf216c97fa3@kernel.org>
 <8d5cca29-2b4d-40a7-a7dd-c3eff625af95@linux.ibm.com>
Message-ID: <7c475cf3-1f76-4be9-8461-946293bb4f15@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 26/04/2024 17:19, Eddie James wrote:
>>
>>> +  The FSI Hub Controller is an FSI controller, providing a number of FSI links,
>>> +  located on a CFAM. Therefore this node will always be a child of an FSI CFAM
>>> +  node.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - ibm,hub-fsi-controller
>> Again, is it for specific chip? SoC? Aren't you using generic
>> compatibles (not allowed)?
> 
> 
> This one is fairly universally supported on FSI (any POWER chip will 
> have it) so I didn't add a specific chip... Should i? Do you mean 
> generic compatibles are not allowed? How generic do you mean?

Maybe IBM is different here, but for every regular SoC the blocks of
that SoC should carry SoC model name/number.

Best regards,
Krzysztof

