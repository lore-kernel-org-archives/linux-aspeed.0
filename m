Return-Path: <linux-aspeed+bounces-998-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A931C28B30
	for <linux-aspeed@archiver.kernel.org>; Mon, 17 Mar 2025 04:31:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZGMW96Wgbz2yd7;
	Mon, 17 Mar 2025 15:31:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742185909;
	cv=none; b=Y7Q1DuVxwJn72awjFkHJKGkTfnA9AS7NEol3jRV/sOPl9bpVPMT+oBR5Galg3r1RNFNAmZNbx4SmEWLwQB9c+8ovi64DNZUbictA9/2EEjXPrquJBqFeaNs3acZsmeK+s5RzuMPje+ywehbaVfkd9cnOZyp7WY3e0sEaX/LzWibDwUTNINL4BdnzZSKnEeXnUct6NTL4KdOvwDofklWdMNl4AauElB/Ht/SRkx3MjDXe2a6dW+CsFN68pef30HR/kwijrufQCx9PiEXvCXaGCncu33msZbl8viocmMYUQNbZQnIqJNJz7iWUVKjDZRMqp3V82u9H9771nlxG54tOHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742185909; c=relaxed/relaxed;
	bh=vgKGpNBvK9Sk4tCd4YTOHPbSQP0l1EqaEPCcjolW7No=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=ZPkhXshz/FvSUaLX1iYKjj/fn6IDuYdepMdIDRVEQ1dCSLtCb89jw8M3Tu9eKD8fIJ0rXMRUvY41jmqc3hTntu5XJe11JpyyBpT8ogjXs0K+SOGPlMeIOPlAJouZIAkqgwhH2lZfgU0pVXzRjf3XHbSw37gFRH25H5A8dhDGQG+HJmRtEmtRIQ5HrwXMticAjTIQEex83kOzrGpL5Vn9H+FUaUWZdiKbXiS8tIwbwrdYgUQNyKI+kFlNoH3swXa1FZkz91GONf4X4ey1Txg1OgRukO3UqgMkxAVoQgM/sJaCN+uA7N3huzh6IRvbLapcTaO1ClQwSaU/VXINsbXUpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=J2Duf+l9; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=J2Duf+l9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZGMW85thNz2yGM
	for <linux-aspeed@lists.ozlabs.org>; Mon, 17 Mar 2025 15:31:48 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B8E7C5C4CE0;
	Mon, 17 Mar 2025 04:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B52AC4CEEC;
	Mon, 17 Mar 2025 04:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742185904;
	bh=Z0a2dhsGygTnIpjglItX4bKcLEMQVArwLyKFp0XhQ7I=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=J2Duf+l9JOfm66hAwT4GUElZZFPEiS5aUgZHtsKTCQxxJIYBZ8mmbA4euOKDQZm7d
	 RujhJlwwh5UKJF1upR1yRrDlQ2eH7gzcXkoaNPO9gXQ4pq3NCNaxoeSppCdpm03CBK
	 ksiJhW+a0Pw596ntBQRdv+xffFhcRmyYgdI8k9r016hyjuSEF9MkZyX3wQvDAwZe5Y
	 t0Sg7NyZgFqgJTcg5NI/P+FSI9L7F+PoNxe8gQExzpaELQ/ZfPzrik7viwNv/nH/p0
	 zOwYW3i3m52g+AEs2+GkBu5qo9fE8ttUPJ8rwXF2/lzz0Mq010mYiOT/purkAGt/2A
	 UjsNYgBY5tG1A==
Date: Sun, 16 Mar 2025 23:31:42 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: kuba@kernel.org, krzk+dt@kernel.org, linux-kernel@vger.kernel.org, 
 BMC-SW@aspeedtech.com, conor+dt@kernel.org, ratbert@faraday-tech.com, 
 joel@jms.id.au, andrew@codeconstruct.com.au, devicetree@vger.kernel.org, 
 pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org, 
 andrew+netdev@lunn.ch, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, davem@davemloft.net
To: Jacky Chou <jacky_chou@aspeedtech.com>
In-Reply-To: <20250317025922.1526937-4-jacky_chou@aspeedtech.com>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
 <20250317025922.1526937-4-jacky_chou@aspeedtech.com>
Message-Id: <174218590293.2844402.7312672269180234107.robh@kernel.org>
Subject: Re: [net-next 3/4] dt-bindings: net: ftgmac100: add rgmii delay
 properties


On Mon, 17 Mar 2025 10:59:21 +0800, Jacky Chou wrote:
> Add tx-internal-delay-ps and rx-internal-delay-ps to
> configure the RGMII delay for MAC. According to
> ethernet-controller.yaml, they use for RGMII TX and RX delay.
> 
> In Aspeed desgin, the RGMII delay is a number of ps as unit to
> set delay, do not use one ps as unit. The values are different
> from each MAC. So, here describes the property values
> as index to configure corresponding scu register.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  .../bindings/net/faraday,ftgmac100.yaml          | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml:71:8: [warning] wrong indentation: expected 6 but found 7 (indentation)
./Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml:78:8: [warning] wrong indentation: expected 6 but found 7 (indentation)
./Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml:119:7: [error] no new line character at the end of file (new-line-at-end-of-file)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250317025922.1526937-4-jacky_chou@aspeedtech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


