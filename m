Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3861D606A31E
	for <linux-aspeed@archiver.kernel.org>; Fri, 23 Oct 2026 06:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=jI4hJIO2
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9tWw37c7z2yFQ;
	Fri, 23 Oct 2026 17:33:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792737228;
	cv=none; b=aKp2bjR8yRRANagc+jP+rJEWhWsaxpatgLzBSvW2eH5ZbMa6o9i7CkDOQxDfjWE8Jb8ie4CqvX8pBwU8d01/GyCipwtAhafbbVd+IgnPO9ey4Ih0qSnruTnthBi8ToODQC9sKKIUtRXrG/J4Rhv8xkL4NOWaHtS3X/BEDCVUAWvn5UIGcND6NMDHJD87MVoyA8WYSv+WOQbFdQXBfZxF6BE8GhiFepTL3zwTvOw7Itz9pR93qXzdM7BfMZM7Q1/mgqOVWVymvLCZH9BDvQ/sl4GVd8O9WMwO9h3RSesNGUoPXVSAEVyn+SNo/cDNq+RLLxyfAYybqlo+4ct3i49ong==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792737228; c=relaxed/relaxed;
	bh=uw96e8wxJn4dRmmYbzz6TU2vxUmejS4+KFRn+pnou54=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kgF2pKHQMS3213DUYAcSg52ZcGAoPgjJQQakfdu0H9vtVkur9HGQ9DsHLPiPeBsnAPmzWo3KmZVXaG11oJ7TI94/UMg9TR/m4R6LmMnPTHLMGYEZwMg9HHl/k2QedzXNFXflXxAmKe8AeIE9wtb/NKuTi8CR/fG+IVsSxxDohfsY2nPWLb/TFsk85x/T7ImELqEtWlSUlguu0e9x8xIk7GtQhn2Y9GCZ4nxJ8SOR1sdbs00udjCkHI7gLlCrTKElkVIwFKsM9aYwGpi5fKnozDmyx0uIUOf3BsyeNcb1v0L/Os/1HP737zHm2ksf2dHWbBCR93G8zxSdRxHW9jN37A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=jI4hJIO2; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=jI4hJIO2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9tWv4QzFz2xSl
	for <linux-aspeed@lists.ozlabs.org>; Fri, 23 Oct 2026 17:33:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1792737226;
	bh=uw96e8wxJn4dRmmYbzz6TU2vxUmejS4+KFRn+pnou54=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=jI4hJIO2SpFbTa6a/xXNcbZgfUBwadU86IGVap5dP6Byi7M6nGFiAXg7pIBc4izeL
	 hrArl7CTP5kcpnRgw6iWhqQCeIYGiFc5fc413gzfLagIfttLPLS+8WPfVbVoiAUdQG
	 fUok7Yy7kd3VnMM2FXnr5NDeu6J+3xJz/XN9O5D4ghwO+wf/C38fV562uJgkukoxl9
	 t8/3fnUk0ZQ3zj/rytOOJsD0TvSkFbFp0ytsiPIl2awnIM8Ffx4pDNiDO1jsbFlloW
	 XA8furCsfhg+ziBpVU+alqMDJ8NJ14pM7sURDZ2uRYpcZDGjCtbJd8m0Zi/AZrh0Nm
	 MLs6HVQzCKYoA==
Received: from [127.0.1.1] (unknown [180.150.112.139])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C82946C53B;
	Fri, 23 Oct 2026 14:33:44 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20261016-ventura2_initial_dts-v10-0-a546659a084b@gmail.com>
References: <20261016-ventura2_initial_dts-v10-0-a546659a084b@gmail.com>
Subject: Re: [PATCH v10 0/2] Add Meta(Facebook) ventura2 BMC(AST2600)
Message-Id: <179273722468.1026112.15880414807402176715.b4-ty@b4>
Date: Fri, 23 Oct 2026 17:03:44 +1030
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
X-Mailer: b4 0.16.0
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 16 Oct 2026 16:50:28 +0800, Kyle Hsieh wrote:
> Summary:
> This series adds the device tree for the Meta (Facebook) Ventura2 Rack
> Management Controller (RMC), which uses an AST2600 BMC.

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


