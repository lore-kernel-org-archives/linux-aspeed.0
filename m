Return-Path: <linux-aspeed+bounces-3592-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C84EFCE53
	for <linux-aspeed@archiver.kernel.org>; Wed,  4 Mar 2026 23:57:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fR8jy70Gpz3bf8;
	Thu, 05 Mar 2026 10:57:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772668662;
	cv=none; b=UTgSIq5Jhi8cIRQFlBehwCq4F8aUD7+bBGhMrDRaE8w4ot4P0+FdRbTu6iVPXZTpFLBDVth+IbHpI5oCuk3d3fy9OfkIc684PMHjZ1zYX9/TA9aqqva0WM6LsYlRmeS0XhEbyxfcFqsGQu4ru8yfA2jO5F/C6ioX9QwoR1+TGCi1AcCLgJ5Z+23zkfsY0zmNuXiJmj91WEBSu26kp4pPOQ5GMxNToT3mMcbe1s3btWmVyPTSsO4fCwxmgwAF0caZUiePcW/zeguEtjv3qGNU8S0198M3Np6kjDL0+KmWcgjrmyWN4Gg6qSdH6/R/fYQPHwloM+qGf3xLSPAj6CRyQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772668662; c=relaxed/relaxed;
	bh=gIGwrCqPlTvk8g05dxZBjXzxv9TdKNafDRbPwLq0ZSI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UySN6PCCringg3hQdAqZZ+TeEPvekLMKoR7nETQ4bw3V3v2uQVwPr6V31nRWT4PpZOQqinL72IAX8Eib/7VC1dSkMe3fmKyzyPkIsBgHLn64JevEZH65qhjBdxq862JHPJwd2gbXqgm8LdVoE65e9UJVkoEzKBHHEymiXBsfaY5F7kkbb4DLZhilw9oEy9yHPraFa7ZqnV67zvuiWNsGOe6waWKADJS20HQUGl8CQE3QhDdqkSJAAkneOZlCMkOMy/qoznz5C84OvAEMAYvUaWVhqJ9vvhY2i7HuvGoJVfNIcLFY2FQF5vRmC39QaE0Zj5c/58QH4FwAcjghoHrSMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Wgo5VNoT; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Wgo5VNoT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fR8jy06Xcz30FF
	for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Mar 2026 10:57:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1772668660;
	bh=gIGwrCqPlTvk8g05dxZBjXzxv9TdKNafDRbPwLq0ZSI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Wgo5VNoTLL2efzHKlpFefxV+cqSmR3SHo2mShMBZS50s4ZhhSnQ3SRU+9WhDd5KzM
	 cF39e6AqZ34dIkPctLlSnC5QqGjWIp85FJmu5FI4oYMrT6/IvnDgY74CsUrSNCX8P9
	 SXZJnv+gIQaud0xbHfY3J+hVsu5IDgjN9apWk7VmygQgzMUeb9sTSvqjzfhrjM8YrS
	 OIgZlmtOYchjPpLU60OcWtRsCZqoWJIE+IDTtn645bJ2yE4J9wotU1clhEc3EewXxc
	 chO3xZYQljCx/CtvjZZ0s+5p1m+V8sEhs1hEcUHZqkWpkLUxtTXbEuQIEalsqBoJi3
	 BAGuBAXUjix3g==
Received: from [192.168.68.117] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 46F0760C90;
	Thu,  5 Mar 2026 07:57:39 +0800 (AWST)
Message-ID: <3e9d0b356ad2871de0b3a47194726d3503ef136e.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2] ARM: dts: aspeed: anacapa: update SGPIO and PCA9555
 settings for DFT
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Colin Huang <u8813345@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Colin.Huang2@amd.com, Carl.Lee@amd.com, Peter.Shen@amd.com
Date: Thu, 05 Mar 2026 10:27:38 +1030
In-Reply-To: <20260226-anacapa-dts-sgpio-v2-1-fd76828616b8@gmail.com>
References: <20260226-anacapa-dts-sgpio-v2-1-fd76828616b8@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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

Hi Colin,

On Thu, 2026-02-26 at 22:08 +0800, Colin Huang wrote:
> This update adjusts SGPIO mappings and enables interrupt support for the
> PCA9555 GPIO expanders. These changes are required as part of the DFT
> (Design For Tooling) integration and are aligned with the SGPIO signal
> definitions provided in Helios_SGPIO_BIT_MAP.xlsx (rev: 2026-02-16).

Where can I access Helios_SGPIO_IT_MAP.xslx?

My suspicion is I can't, in which case this doesn't have any business
being the commit message.

>=20
> Updates include:
> - Add interrupt-parent and interrupts properties to PCA9555 nodes to
> =C2=A0 enable proper interrupt handling required by phosphor-gpio-monitor=
.
> - Correct placement of LEAK_DETECT_RMC_N.
> - Update SGPIO line-name mappings per the latest Helios SGPIO bit map to
> =C2=A0 reflect leakage channels, presence pins, module power-good, and ot=
her
> =C2=A0 DFT-related monitoring signals.

Please take some time to read through the documentation on separating
your changes:

https://docs.kernel.org/process/submitting-patches.html#separate-your-chang=
es

If you haven't already, please also take the time to read the rest of
the document.

Andrew

