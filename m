Return-Path: <linux-aspeed+bounces-1034-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDA2C282EC
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Mar 2025 08:45:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZH55Q2XvSz2yrR;
	Tue, 18 Mar 2025 19:45:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742287530;
	cv=none; b=VQHv+4dosZ7r7/7Oh8/ftuWSVjU2WJLPOKyqlmBS8Byftf93u/Pidr93btf2uRpU4UdESxBsLpNfW0F0labY+756GAD2TERX3M55PyNnIMMb32YX5K6Dm17LxSA6iL07rZstgR/N1janWY+PlMki06hwZelvPVGNHDmxl/1NJk0CUG/52Cdr7+IFa+Rg/HjMutLw9EUKPApzvnnQILKtcNs9Ol9swPDOqWdlVM8ONj3+d6TcrOzaopzWu7PEpFeralp8CEBlWTfZPwPZHisMIvS33ynVdM1ADI6EVbGr17nTWWyAZ5EfaGmgdQ8uXPpmYnuxTB9dW/5NV2JmVCjJHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742287530; c=relaxed/relaxed;
	bh=pQa+8tLXCh38wxpuqC/UFWJialaNOAJe6R4eCwrtJlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArrDYF7x2i+Ep9WIb4V2/UMskTpIGSORZf0AGaLy/gyHBCwUzItDnJDADtb6Yp3VKOjkNV234+a7ABa6g45TYJ7W732tkdg/uoVVhnXNBMpaLTA1f8bYvpmSPtcBzrxO5WBaBideIugjSdIJxkxWUqkn231H8tslrIBJqEtaeqSL+gIA2JJVQpWarxqVobzWD6h+UYaBzvMDZ3Zz7FRMvyIAcZX2C/XCSPbeGOKX+BiB91GOZG3BzXtYCDA3V39pTj2UIZIw3yLs+NTzLsN/jj4MLgBBGO7htEkCaS9l4Q8r/Kf4ZAN/UX0wCK/Jcx1y9nF/eeg7ZITlspsrXDEY7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mc0mPIzZ; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mc0mPIzZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZH55P4lNCz2yrQ;
	Tue, 18 Mar 2025 19:45:29 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0231D5C5556;
	Tue, 18 Mar 2025 08:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF98EC4CEDD;
	Tue, 18 Mar 2025 08:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742287526;
	bh=xvR4q+kDcK2eJhnkZQxu0f9mq7keqwXDtJByURfUMBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mc0mPIzZcbkoWsgw/Yh+D4VVUkWFdSfIvMFA5e41vglhGpICtIJrlOa7pKfMamn82
	 XhoREwnpMhbcRL1xtHnbrRA632XsL3fcsP8NH8p96idE1tpO0vNe71nx9Wd8Dr4RF/
	 e5FfFG/FimCyHiVF5WIv66uJmd10dlYXedjbxgYSiWLDsmP9kllvAixBNW/kaEPybl
	 N4kbNi0bxwazA1YbOLiyddk2PQQFDssYSSEeHBd2fkIkRvmUbrLzjPjzF6XhTAh0U5
	 jlBP5uEawrXWuILN1fsoDS11F00d8zlB26UoKszf5zwXx40Pj+h7YPX4/KZiGEQI4c
	 6Pi1Pnz7UV9Rw==
Date: Tue, 18 Mar 2025 09:45:22 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rajaganesh Rathinasabapathi <Rajaganesh.Rathinasabapathi@amd.com>
Cc: devicetree@vger.kernel.org, openbmc@lists.ozlabs.org, joel@jms.id.au, 
	andrew@codeconstruct.com.au, robh+dt@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Supreeth Venkatesh <supreeth.venkatesh@amd.com>
Subject: Re: [PATCH v3 2/2] ARM:dts:aspeed: Initial device tree for AMD Onyx
 Platform
Message-ID: <20250318-imaginary-peccary-of-argument-ab6b39@krzk-bin>
References: <20250318041224.1693323-1-Rajaganesh.Rathinasabapathi@amd.com>
 <20250318041224.1693323-2-Rajaganesh.Rathinasabapathi@amd.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318041224.1693323-2-Rajaganesh.Rathinasabapathi@amd.com>

On Mon, Mar 17, 2025 at 11:12:24PM -0500, Rajaganesh Rathinasabapathi wrote:
> +/ {
> +	model = "AMD Onyx BMC";
> +	compatible = "amd,onyx-bmc", "aspeed,ast2600";
> +
> +	aliases {
> +		serial0 = &uart1;
> +		serial4 = &uart5;
> +	};
> +
> +	chosen {
> +		stdout-path = serial4:115200n8;
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x80000000>;
> +	};
> +
> +};

<form letter>
This is a friendly reminder during the review process.

It seems my or other reviewer's previous comments were not fully
addressed. Maybe the feedback got lost between the quotes, maybe you
just forgot to apply it. Please go back to the previous discussion and
either implement all requested changes or keep discussing them.

Thank you.
</form letter>

Best regards,
Krzysztof


