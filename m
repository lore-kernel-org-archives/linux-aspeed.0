Return-Path: <linux-aspeed+bounces-5022-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37634C88E72
	for <linux-aspeed@archiver.kernel.org>; Thu, 17 Sep 2026 22:26:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hm9Mn24c6z2xbQ;
	Fri, 18 Sep 2026 08:26:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789683989;
	cv=none; b=JEnAG5ZAeyu1CR1AYRIx6C/AGsy/bzUmDu1DClyP90cDsm1YOG25NqrzgCrQB6gQrACCnOOvhD7PiEllSAq7vuPTN6L2gPKATIogU87i/X7A7YK1BFa7Js0hr/gl882OJrpBQVvGRR/asHMis9LB25YrAN34vk+dqWb0acLr7NSalUU1UPT6jVfrg7+1Ot+VeqQGoMlwg/IUTVe1SSbyCkPIRfkThYiMFYbv0GIdA3S2S3bzYGPeDrExAHgI751/okFTZfzzCbsBAAFV5eNBztKhDbUigttRSk+v+QPGNQIoLWINV0pBluVGHs/pUGMgqOEd43NV3+NcJpZLldk3Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789683989; c=relaxed/relaxed;
	bh=Hp9mrowOiBNinPIkdPwJdxIaRmTewvkis1qNuqUG7eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUGUDSj2N6BmIFOibtcOMxTFjaGstVhg9NZOxyH+BgmqL85mVtm5ftj8+0vdw/Vtt0VFYK3F4E/+EkdAh6Zg98B8GgxPVbX6s0ucWkerNxm9SiwMHxSJSKrV7D+RcuFM48g/3vj9QrLX2YbBrYIKsdgZ4NI2SnsQKSyoX9xfl9yysgOaQTdLFqHP+xkXNcqODgghxMzM0DH05ORoRHZzqu7ZlqcY130ZsOD+MFuo76s2IZ16e5wSVqarVWi9QWFNWJhlYik1CgwK7RWuRYL91Cva744wsCDm7lU4avkCKtoesFyGfGdw2oruXCilLGVepvAohkXtZhct/anX3lFhNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ejn0xVuO; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ejn0xVuO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hm9Mm0RwXz2xYh;
	Fri, 18 Sep 2026 08:26:27 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8FCE6600AA;
	Thu, 17 Sep 2026 22:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49BF1F000FF;
	Thu, 17 Sep 2026 22:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789683984;
	bh=Hp9mrowOiBNinPIkdPwJdxIaRmTewvkis1qNuqUG7eM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ejn0xVuOyE+Vjz9cxODd86WSyGTH7DjSP+tiPmxvVfp3sUqvcH1kOniuNb1xbDSjD
	 5HdcNGpclFt0/eOx0jd9AkCTvArwlTvroEscLXOKMRoj+xO8Fth5cg7fHbeG22rRc3
	 xAGY4DuGok7eTUetwkTMCSlh5z/GLBokLpadygR0iQG8AtUCkJBHMEN4wyAyOqqvO8
	 uvX/hHTd8EYQ0kNOBsVACcx/eed89Xnn6LT2d98PROCcZEUSS+LhafZa8oR5iqxBY5
	 g3YM583evaItELWO3nw8+9REvSosKJQj0tMeuW65Z7S11f1D9yYjFx8BLUo9ucoVgP
	 GFo+IG8OtranQ==
Date: Thu, 17 Sep 2026 17:26:21 -0500
From: Rob Herring <robh@kernel.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
	Oskar Senft <osk@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Vitaly Lubart <lubvital@gmail.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Breno Leitao <leitao@debian.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	James Morse <james.morse@arm.com>, Paolo Abeni <pabeni@redhat.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Dave Penkler <dpenkler@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Dan Williams <djbw@kernel.org>,
	Mukesh Rathor <mrathor@linux.microsoft.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Julian Braha <julianbraha@gmail.com>,
	Karthikeyan KS <karthiproffesional@gmail.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>, openbmc@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v2 3/4] dt-bindings: uart-routing: Add binding for
 StarFive JHB100 UART routing
Message-ID: <20260917222621.GA4081995-robh@kernel.org>
References: <20260905102901.126035-1-changhuang.liang@starfivetech.com>
 <20260905102901.126035-4-changhuang.liang@starfivetech.com>
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
In-Reply-To: <20260905102901.126035-4-changhuang.liang@starfivetech.com>

On Sat, Sep 05, 2026 at 03:29:00AM -0700, Changhuang Liang wrote:
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
>  .../uart-routing/starfive,uart-routing.yaml   | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/uart-routing/starfive,uart-routing.yaml
> 
> diff --git a/Documentation/devicetree/bindings/uart-routing/starfive,uart-routing.yaml b/Documentation/devicetree/bindings/uart-routing/starfive,uart-routing.yaml
> new file mode 100644
> index 000000000000..1977f2ed20a6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/uart-routing/starfive,uart-routing.yaml

Unlikely to have another "uart-routing" binding, so move this to 
bindings/soc/starfive/.

Otherwise, looks fine.

Rob

