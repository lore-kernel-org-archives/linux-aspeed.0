Return-Path: <linux-aspeed+bounces-1025-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C528EC28B30
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Mar 2025 00:42:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZGtMm36JFz2yfx;
	Tue, 18 Mar 2025 11:42:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742258532;
	cv=none; b=KtSFuf/ek/+dt7rIzl6o5/7EfKpBGgKzM73gX4NLWc6ndrART/2ZYFqhBbZDUUMJVvDf2L6qviy00Sstd7EQ+7couyX7TG4nwA7DNRf+1kpDCQOHl3wBYVmTe65t3XbtpZE9jsURG0iQnG3SyfpCSNQ626JaflVf5jc03Rbv0jhUxABQpfu/8AfsY30p/TTkLWWium6MgnbLZOQQjnPvytSFAk1TjWoBJzcvuv5/qln0iBZ6fd8Ems/40LP7xB49cDtuCLBK+65bawEIsB/XlqdSsXO5VveXlynoI6KaEOLAYuLifAXZJRmbK99mDeuX30Swc3KcOU+Sh1FFzYmHFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742258532; c=relaxed/relaxed;
	bh=lR8t+yS8heBlVgKW1sJz63d4wBD18a6lsgVnNjdDSVQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b6R/GdjzTbswDTH85L5ah764Xn9DT6vua+5de7VhthlCXguhm/T8JDrw06J45MKQ7Je22n8V8f81Uxgr9i9idXSujnnWO2QVorR9zpU3avxo+oIfAWJbEnzGhw7YQARzT4EK5WcbmIFvN2OtXCzQo8Whvei51aXOGVVKIx/e6GiTjpAQLt6kshlY4RTM7RfCsTH1wwVKoXB3jZudzTZAEW4DQkBKxw1HgxFrUDg4mpI9EyQ7v+SOPyoGGlz8s/15JxjIYIzkW2Mz3yvmu3TSrfmQcq1+p9DwJbjm+fTC3//EJIVvNALnnox9jAVeqTyTjtaodgXvpeE7Tt1e+eNHwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=VCrCjVVy; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=VCrCjVVy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZGtMl69zqz2yfv
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Mar 2025 11:42:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1742258531;
	bh=lR8t+yS8heBlVgKW1sJz63d4wBD18a6lsgVnNjdDSVQ=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=VCrCjVVyQloxxKR8/vCcZEWhl5wH0TbTJ4YXNsdM1m459vlb+65LMjGKP9CX0nAE3
	 tJVaa65qgKEVGMBQaMuBNgaUr2xf4SwItxGtuNyXBJkewIzvA5uR7erUJtb8sgEzpk
	 bCLcwZCAnwgGIpGHa4WgGbF36CygZqJb3KrWPqYAUxhJI6gYa8dJD3qzxuItCr8tr5
	 swVtXVVcdY1W60feoPSNlo2DZwjj/AzN5xf9RO7oa1o855/zcvlLazk2hUIpYMSI2D
	 7eyN38fQyZ0ny1Tox+1N2Tv3H9aRHFKruU9MNJ0ShUS8gKOyIwRx8usmnzVYMmyZ1E
	 1kpKwxR4WSWrw==
Received: from [192.168.68.112] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5A04377BB4;
	Tue, 18 Mar 2025 08:42:10 +0800 (AWST)
Message-ID: <3270a7ea55fa28253b435da0b0bbce3adfdc00eb.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kevin Chen <kevin_chen@aspeedtech.com>, lee@kernel.org, robh@kernel.org,
  krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
 derek.kiernan@amd.com,  dragan.cvetic@amd.com, arnd@arndb.de,
 gregkh@linuxfoundation.org,  devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Tue, 18 Mar 2025 11:12:09 +1030
In-Reply-To: <20250314112113.953238-4-kevin_chen@aspeedtech.com>
References: <20250314112113.953238-1-kevin_chen@aspeedtech.com>
	 <20250314112113.953238-4-kevin_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
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

T24gRnJpLCAyMDI1LTAzLTE0IGF0IDE5OjIxICswODAwLCBLZXZpbiBDaGVuIHdyb3RlOgo+ICvC
oMKgwqDCoMKgwqDCoHBjYy0+bWRldi5wYXJlbnQgPSBkZXY7Cj4gK8KgwqDCoMKgwqDCoMKgcGNj
LT5tZGV2Lm1pbm9yID0gTUlTQ19EWU5BTUlDX01JTk9SOwo+ICvCoMKgwqDCoMKgwqDCoHBjYy0+
bWRldi5uYW1lID0gZGV2bV9rYXNwcmludGYoZGV2LCBHRlBfS0VSTkVMLCAiJXMlZCIsCj4gREVW
SUNFX05BTUUsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBjYy0+bWRldl9pZCk7Cj4gK8KgwqDC
oMKgwqDCoMKgcGNjLT5tZGV2LmZvcHMgPSAmcGNjX2ZvcHM7Cj4gK8KgwqDCoMKgwqDCoMKgcmMg
PSBtaXNjX3JlZ2lzdGVyKCZwY2MtPm1kZXYpOwo+ICvCoMKgwqDCoMKgwqDCoGlmIChyYykgewo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfZXJyKGRldiwgIkNvdWxkbid0IHJl
Z2lzdGVyIG1pc2MgZGV2aWNlXG4iKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Z290byBlcnJfZnJlZV9pZGE7Cj4gK8KgwqDCoMKgwqDCoMKgfQoKSnVzdCBhIG5vdGUgdGhhdCB0
aGlzIHN0aWxsIGlzbid0IGFjY291bnRpbmcgZm9yIGRpc2N1c3Npb24gb24gdGhlCnByZXZpb3Vz
IHBvc3Rpbmcgb2YgdGhlIHNlcmllcyBwdXR0aW5nIHRoZSBkcml2ZXIgdW5kZXIKZHJpdmVycy9z
b2MvYXNwZWVkOgoKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2Y3MzY5ZDYyMDVlMDVjN2Fh
YzNmM2RlN2NiZDA4YzNiMDg5NjBkNzUuY2FtZWxAY29kZWNvbnN0cnVjdC5jb20uYXUvCgpJZiB3
ZSdyZSBub3QgZ29pbmcgdG8gdHJ5IG1ha2UgYSBjb21tb24gdXNlcnNwYWNlIGJlaGF2aW91ciBv
dmVyIHRoZQpBc3BlZWQgc25vb3AgYW5kIFBDQyBmdW5jdGlvbnMgYW5kIHRoZSBOdXZvdG9uIEJQ
QyBmdW5jdGlvbiB0aGVuIEkKdGhpbmsgdGhlIGJlaGF2aW91ciBvZiB0aGUgY2hhcmRldiBzaG91
bGQgYXQgbGVhc3QgYmUgZG9jdW1lbnRlZC4gQnV0IEkKd291bGQgcmF0aGVyIHRoYXQgaXQgd2Vy
ZSBjb21tb24gdG8gYXZvaWQgaGVhZGFjaGVzIGluIHVzZXJzcGFjZS4KCkFuZHJldwo=


