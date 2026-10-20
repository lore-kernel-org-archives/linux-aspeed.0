Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D86E606A31A
	for <linux-aspeed@archiver.kernel.org>; Tue, 20 Oct 2026 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a8foUJMU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j8HtP3G4lz2xwd;
	Wed, 21 Oct 2026 03:29:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792513757;
	cv=none; b=ZTmXZqjUdz7HU/1KpWEB2aog3lW5eGc2Cx9bJnC7Pn0zPSOrrT6pt5S0hP6ru5XqbkKT1onkexaSQyAKBs3H9M/MlZRaioLHlQQgFi8bw5VczFKIr6yCcx8ps3doZHp6EpqHnrdLHedlC2wobWK867S3O4P7CXKp7xiZpxnhnybUCdmh+JIAy6Rv5p1ZpapqpQ8KGU//4lA52Xks2mTCZGPb51r5XYPxlwVwFVdwTCcGkuXvBlPDOW7m4yvth2ybhyDUciZEi3r5tD1rP+6UOzDNmfSdlyc9vf9zykRCw4UpeJ1iUKzwxmEGQWv1ZDHWTLqVDAcZbHQQ8P7MXZr9Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792513757; c=relaxed/relaxed;
	bh=+jdyq0Zfmu33A//X/4Q8SrSfQyWMMoDDtV5zWpBiENk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRSlTdlFe2djcVUvZ8XzDCslSx73aQP8rA9nyZioqZIBR0IUMfPyNP49ZMldMvlXBOCXzWPMSfYMLs/hNvuoVdDAv7Q6k4q2Oso8ltNCIvhGlgLT4kGQk9VjAFwVxQQsNA2HBkbYZamtBA3ywl04QokCDgBLkVtxjut5+OqDUCxWj2ExUFQiVK8tlD7rWH8uH2vyzylzBOFVpoXCt0LzHTduqx8bZYVQInQaixeO/dtf7GLqN/0gGFMoFmfSwFVS1Lp40zf+R56pOayc+QEY5/FauamM+8flbF+9XlMEskpl0c4bsOOy3ihg89ySdelbeZa0+HM/qHrcYA3fIBADAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a8foUJMU; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a8foUJMU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j8HtN2vbsz2xly
	for <linux-aspeed@lists.ozlabs.org>; Wed, 21 Oct 2026 03:29:16 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 19F2E601F9;
	Tue, 20 Oct 2026 16:29:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7161F000C4;
	Tue, 20 Oct 2026 16:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792513752;
	bh=+jdyq0Zfmu33A//X/4Q8SrSfQyWMMoDDtV5zWpBiENk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a8foUJMUqu5P8nKNaWlNLtBvXMXfnCOSwrfbCydwXzOCOwyOLWOebj+1l10GTer8h
	 zsAEyQyGQeia0G4wyPi8tP1/HOz3S1r6tDqL0O0E+QAaxHrxPasJbjvusut16walxr
	 2LyYRwbJnG68aDBb+FHDuG2OVSWQfJkotjPte4vOcuw+eISVmy0eBtTPL2Mz4eLmKk
	 aidzs3wwJ0pkxCpHds+sahsI6kBunz76pRCaGuflKNYQ/kkZ5XJlFS2UGfO7rcRBKR
	 d5Dd+DhMu5yPj6Lhbah+g+UMaR3fghb9giemCvasfEds9TP68TCT0zTjQU5q2mkom1
	 GaGDfgsY9luRA==
Date: Tue, 20 Oct 2026 11:29:10 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>, linux-aspeed@lists.ozlabs.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-kernel@vger.kernel.org, Ryan Chen <ryan_chen@aspeedtech.com>
Subject: Re: [PATCH v10 1/3] dt-bindings: phy: aspeed: Add ASPEED PCIe PHY
Message-ID: <179251375007.3988760.929772865298588176.robh@kernel.org>
References: <20261020-upstream_pcie_rc-v10-0-fba209af8656@aspeedtech.com>
 <20261020-upstream_pcie_rc-v10-1-fba209af8656@aspeedtech.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020-upstream_pcie_rc-v10-1-fba209af8656@aspeedtech.com>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Tue, 20 Oct 2026 19:59:49 +0800, Jacky Chou wrote:
> Introduce device-binding for ASPEED AST2600/2700 PCIe PHY.
> The PHY provides the physical layer used by the PCIe
> controller when operating in root complex mode.
> 
> Describe the compatible strings, register range, clocks and
> phy-cells value required by the PHY provider.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  .../bindings/phy/aspeed,ast2600-pcie-phy.yaml      | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


