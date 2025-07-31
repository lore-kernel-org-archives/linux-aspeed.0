Return-Path: <linux-aspeed+bounces-1870-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B65C87FDA
	for <linux-aspeed@archiver.kernel.org>; Thu, 31 Jul 2025 22:12:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4btNcZ3Fqmz2yZ6;
	Fri,  1 Aug 2025 08:12:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753999966;
	cv=none; b=ZsSqB9i953IgPVZLI96gSSNbBgccyD/QqS/DgBLHRoDmErla5gpjLTzSXAmND6OAhdlPgETYRj2hj/GvwiFu5rzFNTNY8eb26SBiJDsS10MlC5PM9FUv02BLEA88iEe54RvQzEpuUrwsNYKxfN+IOKq1j+Bwt5meK3ANUxlsQ9OklEqpQhSH8t0iKxm5KZexEW2ed5YIhpPgRYybRu7cXUtv1ZsSUNopVgOfR71gk8FTjzxWBeboOGFUpRUrlsQDWuL4/L9z/Ee0+SL0+fhJmqjkOZ7Ve32XGYoiMbgacVywmfQwlVOic5Wi3Kv2vTss20a78r+1qGd9zZoWk3wr/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753999966; c=relaxed/relaxed;
	bh=kHj91cBJP4UCmkQVDHlswFtyp58W2+u6yWfvVBawNZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rh+p11/4wmnPBKim0HnXtrcHp8rsYyQpgB7zmIbe3kOM8Ekc9BBlQ6lhWw7TRdLfQTFc3a8rCFixbJMCyj9EQL+PqYiDJZicYL9+CX3pzqHvuaSppOAEB8hRgAW0ZEOkHIgWFiS/2BBMMnVKGBMv4d3VpzKSKDbrSnsMyzn26/LxdfIbB2bkwANck4duGHRXfsTTFcQ1/QjDSU24yukpCDe8KI4YyYkUUad9dpJtvm+Aywv0WiyrA83scTL41oM9Gff9pNkgtAWsMkONaNLtwt2x86QU0TEPdt9gfm7sAeIftXgcNMq5cerQwWQj8bKRIo8GEE7hgACTHsOLB8NMsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iCvpK9I8; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iCvpK9I8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4btNcY2KNkz2y06;
	Fri,  1 Aug 2025 08:12:45 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8225143A42;
	Thu, 31 Jul 2025 22:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50176C4CEF8;
	Thu, 31 Jul 2025 22:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753999963;
	bh=hPXs+VvV1Z0lvnVsLb9P/CrQ7tEFhXZWjhaO05I861c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iCvpK9I82kPhEpK8t1h0Ne7/It67WKDWjCgnmWYXCS/tRB8rDtmureWGGG9qIRa8R
	 Mj87Ii6KoBomAr9zGp3jVH8ws2BgF0nXYrQQSOcRxe7pZUQmtNh0Mz9NiiZK+7vG2i
	 iiCJPiHuoiCmz/VY+BLz5EsGGj5wVQrnM4yjo+s+EWWCpZWytDQRTj+3kIKJE8NTwc
	 YxuhxrvavW3NHcI6J+fmgoSeKmDvCxaFoVF7IgE0HNEEiLyTCHeFDbu8JrOg3CHx7c
	 DziRGP44pSyglPL5umjP3Fd4W77aCbZCJox7ncqdJd5F63fpMBYK5fh0zKT4LvD7/C
	 bXxP3k5x87i9g==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 31 Jul 2025 17:12:21 -0500
Subject: [PATCH 4/6] MAINTAINERS: Add FSI bindings to FSI subsystem entry
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-dt-fsi-cleanups-v1-4-e7b695a29fc3@kernel.org>
References: <20250731-dt-fsi-cleanups-v1-0-e7b695a29fc3@kernel.org>
In-Reply-To: <20250731-dt-fsi-cleanups-v1-0-e7b695a29fc3@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Eddie James <eajames@linux.ibm.com>, Ninad Palsule <ninad@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-fsi@lists.ozlabs.org
X-Mailer: b4 0.15-dev

Maintainers of a subsystem should also be the maintainer for
corresponding DT bindings. Add the FSI bindings to the FSI subsystem
entry.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa16..4a7b4656822c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9810,6 +9810,7 @@ R:	Ninad Palsule <ninad@linux.ibm.com>
 L:	linux-fsi@lists.ozlabs.org
 S:	Supported
 Q:	http://patchwork.ozlabs.org/project/linux-fsi/list/
+F:	Documentation/devicetree/bindings/fsi/
 F:	drivers/fsi/
 F:	include/linux/fsi*.h
 F:	include/trace/events/fsi*.h

-- 
2.47.2


