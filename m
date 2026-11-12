Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9605C606A8BE
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Nov 2026 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W/JWJ4q0
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQHxP6JCZz2yLY;
	Thu, 12 Nov 2026 22:20:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794482425;
	cv=none; b=Zyxn8v0LR0Fc0rUKv710e1GMoXWtdbCsa2TNLmkFIDjx91+XJggkMdRwKiS3EqgIaE3ED3BaoPtPgDL/wWo7xKVu4NG+WmaMDUnpEJsnZXBdgHufDiZ7A5YPQPbAMoWptyxq3rS0IwyDxVRXe/IlSH3z1jSPIyOb2QllX49jASfUpmh0gjzwtbcGch4IHHhZuUzTOf/m1A72hKIEIarqH1x8KWw3TuEVkd+G3iJrm2PYoMqcf/QqFPJNY9Vor3VqB5HenavoKdJsJyzD0ZxAXmVQA7peea3sPJ6brvihBn0ckelFEo4djRONmNzdFa21p/Zd1wwqY55dgUorIjrQ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794482425; c=relaxed/relaxed;
	bh=D0muWOhoQ0tEZKS30AGh6Dci91ILHagLlBaq3eYFtng=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bFb8tPYQnLAJDcjKSGFQDEg54gg0ju1Isds/IhhM3sTnKxaQ/2e3iGnox3WAzbD6pCxqATuH49Tm4NuQDd/jLMOfDPCH6iP2aidOaVxgexfE7ce3Ul53N2DDQxp1BD+KhWigMLViNQURKT4OVzGJ/76mD3o9pppoEOWTpYAqffxd5/ym6z62VU20IuzP4IYDJ9UeKpxSm+iXqg9ombW5CyxYHA8CyAXrpzO/rSH9kyYJzz6qMVNwcu36Qok7lZQvu/W32o+Dq7kcLt13LsCPx5A/209gl4grubMwNnBxkS7+Dk6hUdY54yOpkTeoKvBxO40lZkM4nwjKty2rIWD3qw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W/JWJ4q0; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=vkoul@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W/JWJ4q0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=vkoul@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQHxN74fKz2xns
	for <linux-aspeed@lists.ozlabs.org>; Thu, 12 Nov 2026 22:20:24 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 54B70479E6;
	Thu, 12 Nov 2026 11:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6431F00AD8;
	Thu, 12 Nov 2026 11:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794482422;
	bh=D0muWOhoQ0tEZKS30AGh6Dci91ILHagLlBaq3eYFtng=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=W/JWJ4q0trAwrNUTMwd48kyOdE2oujP6zEW7lypxH+tskkuk6rRNqy4YJh89lu78D
	 Gh5dV03HXI5iRQphl6ZGbAJ6NCrAL41KUSaQ/+G+BW3+Zvzkr8t+McTSt0KeqWAjdW
	 xr+Xo7GyAIS+KcH2f6d5Rv0DqPS/cIAzvrlkHSMeM10o++oMq7xgMT6oOvngoya4aE
	 94WFzO6LV5PAwfglSdn64Xn5CiPBGeQR/ORM6gw1tahivyOIhkVI9Y5V8pgq95g2aK
	 QsMO4WjgcD1KoTTzlvHnVeY9w3eIe0aIemLcC01Pym/FKr+F3LdF3//EQd77bF/eYM
	 DIueSeqbKbvnQ==
From: Vinod Koul <vkoul@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>, 
 Jacky Chou <jacky_chou@aspeedtech.com>
Cc: linux-aspeed@lists.ozlabs.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261020-upstream_pcie_rc-v10-0-fba209af8656@aspeedtech.com>
References: <20261020-upstream_pcie_rc-v10-0-fba209af8656@aspeedtech.com>
Subject: Re: [PATCH v10 0/3] Add ASPEED PCIe PHY support
Message-Id: <179448241801.492462.15920568972028232724.b4-ty@kernel.org>
Date: Thu, 12 Nov 2026 16:50:18 +0530
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Tue, 20 Oct 2026 19:59:48 +0800, Jacky Chou wrote:
> This patch series adds support for the ASPEED PCIe PHY, including the
> device tree bindings and the PCIe PHY driver.
> 
> Summary of changes:
> - Add device tree binding documents for ASPEED PCIe PHY
> - Implement ASPEED PCIe PHY driver, including reference clock handling
>   and an AST2700 host bridge reset sequence
> - Update MAINTAINERS for the new bindings and driver
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: phy: aspeed: Add ASPEED PCIe PHY
      commit: 020ee21a7ae584f116183867c41e8f8bddecaae7
[2/3] phy: aspeed: Add ASPEED PCIe PHY driver
      commit: 256cc8295557c134421d0b48ea37f6c9d4f232fe
[3/3] MAINTAINERS: Add ASPEED PCIe PHY driver
      commit: be45a1d5c3fed409d909d031547183144a806718

Best regards,
-- 
~Vinod



