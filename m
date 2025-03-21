Return-Path: <linux-aspeed+bounces-1100-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C04DC28B30
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Mar 2025 01:07:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZJkmw34L7z2yqm;
	Fri, 21 Mar 2025 12:06:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742519216;
	cv=none; b=abeYEbTrSLaQJ0BND5KHiUkIegPwQm00vZv3f8zRtpZLWeIUQ8wSDF55ZhL5fe5VclF8cTgYO5yLQvVyqqrBZrHSGsq/nxVo94D4xoQTx39QZyHGwhXVlQNsUfFA/j9uYIvMyCeDIBN0VYBBXAQVXaVVrflb9rSO47IIoaBYUzt7KDAkLEpkYrZk+F/gVFyVfacVY6vVfpEajsee+cH6/zjNSKml5xjtPIWxUvtCSKFlqnwkDc0P7OvXq6NxDO1bQ+mPhjv1k5K64CixIh27FZTh9hd9U9qPG5GDce1LKWhcd1JQnWpV+y2s6ehgLOvKJRG0XoEZyRj77SaVkyiLLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742519216; c=relaxed/relaxed;
	bh=pIdTixZuNmStjtltpSgBZZbYtUoRIdqSvZd1TvixVG4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WwUmy16wqe27aNqCNVOHGYm1QTi/I7pGUrdVtWNQjQUKTYavGE0ng3c4/JQ5yapYt6p/rcBcZV3PzE0X0ylRNIafSHYoRNA+se93CX1Lukz3bHaJCoQVqhb8Ha25ubwdS2gIabod5oEBa1B8vBigl7eyVhFDSL6oRLbipVZGnhJsfHjzrIFrYXwe0VnU4NdICvVEqN1LtRk9ui9X7D/DcU+MteVc97GBPAG0bhuwZW6nVzg3ssmZ+58tGIS5n6nSie9QyN5N6BhepGJPo1jqQdyuPSr4czQvz4p2ll6XEl9v5DfXmtUAWwNIiD41YPmKRc70o2W6bk4kAi2ho6JwyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=STmLaeeb; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=STmLaeeb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZJkmv6HGvz2yhW;
	Fri, 21 Mar 2025 12:06:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1742519215;
	bh=pIdTixZuNmStjtltpSgBZZbYtUoRIdqSvZd1TvixVG4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=STmLaeeb8JgIPPtTQkTrSNDqYPUrllXY1O8adMuBZaHXPzg3r7xposNnDqGupfi5X
	 99Zta++gSDDl1g6lvrC8XT0hnuAKg1r3RC4z8Zo/QyDKqSgnfrSyFA2MJrdT4WBFl1
	 RUmt/OZ6TxN7GeAG3cVCmiMKGwUSnxBv5Lv4WOi5kgsXZNcVhEykb5ll2kTsc+9Pa6
	 BaiCS7bfJfQEDURlCP4T+9JpGc1mpUmY46UGjImGTinlAXe91pWEhhzlW3nyExDQS9
	 gfDVgpD1XzfZxWWDXw/j4WUCiQMImKu63heMsVU2ep4csPM121OpZcNW44Zwo3oG/U
	 7WLh87jddaPNg==
Received: from [192.168.68.112] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 6DB127AF35;
	Fri, 21 Mar 2025 09:06:54 +0800 (AWST)
Message-ID: <585c2b050a44f4009b3a61cab69f800c88a0cf5e.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3 2/2] dt-bindings: arm: aspeed: add Nvidia's GB200NVL
 BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Willie Thai <wthai@nvidia.com>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, joel@jms.id.au, kees@kernel.org, tony.luck@intel.com, 
	gpiccoli@igalia.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	openbmc@lists.ozlabs.org
Cc: leohu@nvidia.com, tingkaic@nvidia.com, dkodihalli@nvidia.com, Mars Yang
	 <maryang@nvidia.com>
Date: Fri, 21 Mar 2025 11:36:53 +1030
In-Reply-To: <20250320164633.101331-3-wthai@nvidia.com>
References: <20250320164633.101331-1-wthai@nvidia.com>
	 <20250320164633.101331-3-wthai@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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
MIME-Version: 1.0

Hi Willie,

On Thu, 2025-03-20 at 16:46 +0000, Willie Thai wrote:
> This patch adds a binding for GB200NVL BMC.
>=20
> The GB200NVL BMC is an Aspeed Ast2600 based BMC for Nvidia Blackwell
> GB200NVL platform.
> Reference to Ast2600 SOC [1].
> Reference to Blackwell GB200NVL Platform [2].
>=20
> Co-developed-by: Mars Yang <maryang@nvidia.com>
> Signed-off-by: Mars Yang <maryang@nvidia.com>
> Link: https://www.aspeedtech.com/server_ast2600/=C2=A0[1]
> Link:
> https://nvdam.widen.net/s/wwnsxrhm2w/blackwell-datasheet-3384703=C2=A0[2]
> Signed-off-by: Willie Thai <wthai@nvidia.com>
> ---
> =C2=A0Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 01333ac111fb..a3736f134130 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -98,6 +98,7 @@ properties:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - inventec,starscream-bmc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - inventec,transformer-bmc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - jabil,rbp-bmc
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 - nvidia,gb200nvl-bmc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - qcom,dc-scm-v1-bmc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - quanta,s6q-bmc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - ufispace,ncplite-bmc

Please order this patch first in your series, before the devicetree.

Andrew

