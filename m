Return-Path: <linux-aspeed+bounces-5152-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D93FCA5FFF
	for <linux-aspeed@archiver.kernel.org>; Wed,  7 Oct 2026 21:01:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0QWy6Nnxz2xwd;
	Thu, 08 Oct 2026 08:01:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791406862;
	cv=none; b=YgT9dzFTR3Rx+Vd8UTl1siQXVWLKFuOqC2wh5BOis6qrcxIVND4mwSMww73NG4wAIY89az2J08HDrGxLR776Xtn+gzHmcjbb+ZaL7NFfA9vrzLu2RzvX9n5GN7rke3iFggPun0tW2dTx//GMdarFb6S3QZjj/tCYcN5zm8NcX1tS6aPTOUN4BOm9ThKSE0xYU13cHlSi4d5YXdqF4xvZQmkEMqzPiFFmZf4HrqqEwnaPEvmEiZl94kdAlqboUQilt5wDa2E/r61/F5PSNEccVVGiFtrxpY4I3DLpdolX4TvaY8ljWhkAz6ytIA2NGQfbTZDIFE1znFaB1nIyYXaFmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791406862; c=relaxed/relaxed;
	bh=TbYPg3uQU1P6rMt+WuOLQFicMNfbSJBbie5yCmhoZc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olHFyw7YTemSBD4zWjvOR6KB/Xk7cTeMc3BKlnCKI0zzNxlrmQf0DEPDfMCFS/Mvc4kmFtNTDtUI6oqXCRSLbVGuLsE9dVjzDjoO7lh6A5QFXwIURQhuIxFPUumFMuHrdkTfFeYze0F08lPIgLInlyUs74nsNIxeKYsS1StWVXKhMdDINbn0FIZZ/OmHBSnP6eD0KgkeA/VdxIQf90BFjKT7UCRp4GVQWbExhQOnGtLbyhaKk3u84NFCLyg/5ctw785mDDvpaLPEkoy7Np3DNCU4hNG4JpsXb6EtEQu+p5sIpRZvA2qwW+bJvSW0k/kE1oMLr/+M1du622o42s1Xbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DlA7fxez; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DlA7fxez;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0QWy1fGVz2xbQ;
	Thu, 08 Oct 2026 08:01:02 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CFBC260A53;
	Wed,  7 Oct 2026 21:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5168D1F000FF;
	Wed,  7 Oct 2026 21:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791406859;
	bh=TbYPg3uQU1P6rMt+WuOLQFicMNfbSJBbie5yCmhoZc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DlA7fxezfe1z+1SnRn5LXiq7eRXTf4Wa/Mg0y9+59eWKxQT4DgzFaWCEpnRqIVNQE
	 gN0SXj6ZmBT5Rmm3TdrmyP14EHopZyd9r0EXpEOSaFPU2vKvQToybCkN2NK3HbCHMg
	 ST58deOjUKDl3/uZ571L1lEeLRQO0IDXxaHtEMP4+1vE+svI74ZMqDvCPm8P1tx2wK
	 /KWbLmIpzeWWtGHiDJGBuB5wdNR2jq/xcBk7NAtcrpllfvReO7QYQQ9PEhvPB2d2UU
	 w+Mu56IlWXzOVzF+rGDRuhrSUVAYTHRJs2lQKVfRGyK7rS/F41uzXfWm5bzzsnTD4W
	 RHjzI02XRHE6g==
Date: Wed, 7 Oct 2026 16:00:58 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Jani Nikula <jani.nikula@intel.com>, Hanjun Guo <guohanjun@huawei.com>,
	Mukesh Rathor <mrathor@linux.microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Karthikeyan KS <karthiproffesional@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>, openbmc@lists.ozlabs.org,
	devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Dan Williams <djbw@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Dave Penkler <dpenkler@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	James Morse <james.morse@arm.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-doc@vger.kernel.org,
	Alexandra Winter <wintera@linux.ibm.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>, Breno Leitao <leitao@debian.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	linux-arm-kernel@lists.infradead.org,
	Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
	Julian Braha <julianbraha@gmail.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oskar Senft <osk@google.com>, Vitaly Lubart <lubvital@gmail.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: soc: starfive: Add StarFive JHB100
 UART routing
Message-ID: <179140685827.281341.11055156225840359821.robh@kernel.org>
References: <20260925050947.9900-1-changhuang.liang@starfivetech.com>
 <20260925050947.9900-4-changhuang.liang@starfivetech.com>
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
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925050947.9900-4-changhuang.liang@starfivetech.com>


On Thu, 24 Sep 2026 22:09:46 -0700, Changhuang Liang wrote:
> Add device tree binding for the StarFive JHB100 UART routing controller.
> This controller allows dynamic routing of inputs between built-in UARTs
> and physical serial I/O ports, enabling use cases such as Host <-> BMC
> communication via UARTs.
> 
> The clocks property exists in the hardware, but the driver does not use
> it.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  .../soc/starfive/starfive,uart-routing.yaml   | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/starfive,uart-routing.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


