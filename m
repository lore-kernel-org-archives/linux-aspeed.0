Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEC1606A22D
	for <linux-aspeed@archiver.kernel.org>; Tue, 10 Nov 2026 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nT0pKRNz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPCBC2dKLz2y2h;
	Wed, 11 Nov 2026 03:42:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794328963;
	cv=none; b=nvjw4WNXKmmsm7ujMDLPGOVXWNaYIrXjET4ByVUckR6MYPVpHiOC4oLcHR+TAaI1pHV1Pu/pge4lwcWgarosaqDAoI6ZL4G2OSNxPX10UZWXg/F3ToDzKEh1vkcG8MLiFryEDhCtHx+dIzwp3H20aDpNXzypuKFKx97E/rmgFyoMAm6qzeWtalLOq3pxYphya+LWsiX8QM3RdS9vCJDqRD1Af2eYl3IKp/FtWepZaFTcFkQap5LFmQ0ifLjEGHAUnnzxJ/FYUHWW6DXCLVClQOQHGAeARXZtJlaOVrJCUOJbR1USgZWuILmcv+E3Jnt6RAXUR6Vvpi+uLZJ3zeh/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794328963; c=relaxed/relaxed;
	bh=cwTPehP0J/3J+Lb62G7yQ4FlvXwx6KiiQuir6lkIwb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K3L+yfXG0gp5k1aa31hSFNmAf0KRqSTsFEAhpH8V04LEJCIQe6fT9s9hTpbsbgater5sZt1HJSkiGY6CeWtAMKNDq1gql1Y3aQGG9cuia4AGSdDuYbTDSReHqr45rLCUm3PhZwZiZtgyfOg58kKzPVq1RVAqbHjefM3Rrh4IBS7qVBkTnz7VOLwPjj3Qy24XWrA7AYz+zVxifFMUOSpuARlHmCdULs4yL4KEbxtPA7tONOOxQwOA5Hg4WwoeZoFjkVvrJFcI2CsP3wG0F7YwSc3b0VLPlVZ2PGGlGPVVZrtpo3sxCo3OkJHhN4Pb+nfzluDqv+1ZCUbVgxDGkwnOnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nT0pKRNz; dkim-atps=neutral; spf=pass (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nT0pKRNz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPCB86qfFz2xmk
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Nov 2026 03:42:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794328962; x=1825864962;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ri0LQs7oxDDyfXBO67wcYZxb4TvsJ82811I+HyQ0eUA=;
  b=nT0pKRNzxVOn5toPMyFmE3qrx0GSpU6L45hXr2xAyXC9M0gCBWlXSF6x
   LbmS+Ip4jnkejcBzHpnHH9uGJfr2nENmImKcxhDx8EfpY92V8H/5d5ipz
   Gdr4/J0UsJlIaiks96U0C0dq9Cw05jADhzb5LZYm7FNqQhjM90VIL5wsc
   Xi/1/XDLfFJ6x2Z28k8LB/nzF7VPVbNoIpvYkDpG/6b4Y2H7eP+2uXDbT
   sHIG11ht/5tx1/dJHicsvx5eaSJGUTrnw6r1eE0ytuBiSJTWCLgA3LVjE
   CrwrWMiQab8xCGdUSQkSmfLsG0ijQr0pWdAtaUlbzUO0zNkkR4sLJVpL5
   g==;
X-CSE-ConnectionGUID: BfSvriFlS0milYZEmgIVIw==
X-CSE-MsgGUID: 8iUQ7xg+To6hNYBcki7sFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="2960359"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="2960359"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 08:42:36 -0800
X-CSE-ConnectionGUID: uZASnqyqToWTIzEAEQatrA==
X-CSE-MsgGUID: 0bpe4HZuSYm/ys1Z1/CWyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="10068575"
Received: from dawidgla-mobl.ger.corp.intel.com (HELO [10.246.17.60]) ([10.246.17.60])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 08:42:33 -0800
Message-ID: <599f1b31-f175-47df-b074-1915688eb390@linux.intel.com>
Date: Tue, 10 Nov 2026 17:42:25 +0100
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] ARM: dts: aspeed: Add Intel AVCRP BMC
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maciej.lawniczak@intel.com, Andrew Lunn <andrew@lunn.ch>
References: <cover.1794242015.git.dawid.glazik@linux.intel.com>
 <ee6958ba4b93cde4719fbac89c4027964c2236bc.1794242015.git.dawid.glazik@linux.intel.com>
 <fff90721f7892c0285f4fed7fed460c7c1e183cb.camel@codeconstruct.com.au>
Content-Language: en-US
From: Dawid Glazik <dawid.glazik@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <fff90721f7892c0285f4fed7fed460c7c1e183cb.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/2026 6:53 AM, Andrew Jeffery wrote:
> On Mon, 2026-11-09 at 18:41 +0100, Dawid Glazik wrote:
>> AVCRP is an Intel x86 server platform equipped with an ASPEED
>> AST2600 BMC. The BMC is used for out-of-band management, platform
>> monitoring, and system control.
> 
> It's probably my fault to some degree for not providing a better
> explanation of what I was after on v4, and for merging changes from
> others in the past that were pretty lax on the description, but what I
> was hoping for was something more like e.g:
> 
> - f28674fab34f ("ARM: dts: aspeed: Add NVIDIA MSX4 HPM"), or
> - bc83b7353d2b ("ARM: dts: aspeed: Add Facebook Anacapa platform")
> 
> Are there more details you can provide? If there are, I'm fine if you
> reply here with them, and if there are no further concerns I can update
> the commit message while applying the patches.
> 
> This also applies to the JNCRP patch that follows.
> 
> Andrew

Hi Andrew,

Thanks, that helps. I also found one more issue in v5 (uart-routing 
issue), so I'll send a v6 with the fuller descriptions below
instead of having you edit them. Please hold off applying v5.

AVCRP is an Intel x86 server platform. The BMC is an ASPEED 
AST2600-based RunBMC module on the platform's DC-SCM. It supports the 
platform's out-of-band management and exposes board management I/O such 
as the system UARTs, status LEDs and control buttons, while integrating 
with the host's telemetry and management infrastructure.

JNCRP is an Intel x86 server platform managed by an ASPEED AST2600 BMC.
The BMC is the platform management controller for the host system and 
supports platform power and reset control, while participating in 
out-of-band monitoring and reporting for host faults during bring-up and 
normal operation.

Does this shape work for you?

Best regards,
Dawid

