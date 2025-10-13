Return-Path: <linux-aspeed+bounces-2426-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811A4CCD187
	for <linux-aspeed@archiver.kernel.org>; Mon, 13 Oct 2025 02:35:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4clLzw63qQz301G;
	Mon, 13 Oct 2025 13:35:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=111.206.215.185
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760321859;
	cv=none; b=dKeQWeGuE53U20y/pwEI2AVL4u5HS56WOsOKqqnbcrIt4h//zXZrcQnrJsQLlcPbgkzc5DeXlyROhjDamv54CwO5RX16MTPiysLrwsiZ+Px3MCTwomohf3LFBNvym7Ctp3rrLg1hD6h4bncvzasFAxAkPkwhZsezt3/r4ARnkiq3Vkg6vLCuoh62lMnvnpzHEDJy1zkfa9ZFTTsXyvW0Kga0HH7GM5ENfTUZm3rduDRP0Ojsj2wrTE2jvaRV6h9NppSu7P3sNsR5y+iOfSswqkzS8fHDzSWEj59+HrBbpU4DG91cR7E/ZEE3IUeUJHF6Y10+oKYGY3kF8w1/nah6Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760321859; c=relaxed/relaxed;
	bh=wckOwuj24Ij1V2m401eRdyD2GopDhpl7foF6Yjx/7Fk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DzX9Inriafn87I/eaqxFTBa1cssPEZC62zWY8UCAnVQV8g5GEUmjW9gLCEfjyM2VkC241ZrGXnMTSFzvJ32v6On5SwJqJ7xMdo4aAfPHy5At1opjfs06wsViM+ExO+tQ0vlAHkUaLEDAzgQuzCeY8Vpq79avx/z6sutbsRl4yHUja+5/xnZ9Nji7bujcOVQj4j0NxlBwBi4gJpIa0hnBN9ToekJnkdg37TYVltRKS9RmrHHWAjE34/cN5oYSnfTVslvIeuqp7co/rabjuZkuy4Kd//DkZMDBHTz2j2i802X/RcvGddIVlyQj/Aecn2ycyPLN4HV8UwgFDTbocNHlRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass (client-ip=111.206.215.185; helo=baidu.com; envelope-from=lirongqing@baidu.com; receiver=lists.ozlabs.org) smtp.mailfrom=baidu.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=baidu.com (client-ip=111.206.215.185; helo=baidu.com; envelope-from=lirongqing@baidu.com; receiver=lists.ozlabs.org)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4clLbQ3ccXz2xQ0
	for <linux-aspeed@lists.ozlabs.org>; Mon, 13 Oct 2025 13:17:34 +1100 (AEDT)
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Markus Elfring <Markus.Elfring@web.de>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "wireguard@lists.zx2c4.com"
	<wireguard@lists.zx2c4.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Andrew Morton <akpm@linux-foundation.org>, Anshuman Khandual
	<anshuman.khandual@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Hildenbrand
	<david@redhat.com>, Feng Tang <feng.tang@linux.alibaba.com>, Florian Westphal
	<fw@strlen.de>, Jakub Kicinski <kuba@kernel.org>, "Jason A . Donenfeld"
	<Jason@zx2c4.com>, Joel Granados <joel.granados@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Jonathan Corbet <corbet@lwn.net>, Kees Cook
	<kees@kernel.org>, Lance Yang <lance.yang@linux.dev>, "Liam R . Howlett"
	<Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, "Paul E . McKenney"
	<paulmck@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, "Petr
 Mladek" <pmladek@suse.com>, Phil Auld <pauld@redhat.com>, Randy Dunlap
	<rdunlap@infradead.org>, Russell King <linux@armlinux.org.uk>, Shuah Khan
	<shuah@kernel.org>, Simon Horman <horms@kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>, Steven Rostedt <rostedt@goodmis.org>
CC: LKML <linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: =?utf-8?B?UkU6IFvlpJbpg6jpgq7ku7ZdIFJlOiBbUEFUQ0ggdjNdIGh1bmdfdGFzazog?=
 =?utf-8?Q?Panic_after_fixed_number_of_hung_tasks?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQQVRDSCB2M10gaHVuZ190YXNrOiBQYW5p?=
 =?utf-8?Q?c_after_fixed_number_of_hung_tasks?=
Thread-Index: AQHcO3v66ZG2hk4PtE6ORt/xqoKtirS/VpVw
Date: Mon, 13 Oct 2025 02:14:58 +0000
Message-ID: <2b19bac7de174fe6baa07234b88c8156@baidu.com>
References: <20251012115035.2169-1-lirongqing@baidu.com>
 <0aea408f-f6d7-4e2d-8cee-1801ad7f3139@web.de>
In-Reply-To: <0aea408f-f6d7-4e2d-8cee-1801ad7f3139@web.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.127.72.21]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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
X-FEAS-Client-IP: 172.31.50.45
X-FE-Policy-ID: 52:10:53:SYSTEM

PiDigKYNCj4gPiBUaGlzIHBhdGNoIGV4dGVuZHMgdGhlIOKApg0KPiANCj4gV2lsbCBhbm90aGVy
IGltcGVyYXRpdmUgd29yZGluZyBhcHByb2FjaCBiZWNvbWUgbW9yZSBoZWxwZnVsIGZvciBhbg0K
PiBpbXByb3ZlZCBjaGFuZ2UgZGVzY3JpcHRpb24/DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL0RvY3VtDQo+
IGVudGF0aW9uL3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLnJzdD9oPXY2LjE3I245NA0KPiAN
Cg0Kd2lsbCBmaXggaW4gbmV4dCB2ZXJzaW9uDQo+IA0KPiDigKYNCj4gPiArKysgYi9rZXJuZWwv
aHVuZ190YXNrLmMNCj4g4oCmDQo+IEBAIC0yMjksOSArMjMyLDExIEBAIHN0YXRpYyB2b2lkIGNo
ZWNrX2h1bmdfdGFzayhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnQsDQo+IHVuc2lnbmVkIGxvbmcgdGlt
ZW91dCkg4oCmDQo+ID4gIAl0cmFjZV9zY2hlZF9wcm9jZXNzX2hhbmcodCk7DQo+ID4NCj4gPiAt
CWlmIChzeXNjdGxfaHVuZ190YXNrX3BhbmljKSB7DQo+ID4gKwlpZiAoc3lzY3RsX2h1bmdfdGFz
a19wYW5pYyAmJg0KPiA+ICsJCQkodG90YWxfaHVuZ190YXNrID49IHN5c2N0bF9odW5nX3Rhc2tf
cGFuaWMpKSB7DQo+IOKApg0KPiANCj4gSSBzdWdnZXN0IHRvIHVzZSB0aGUgZm9sbG93aW5nIHNv
dXJjZSBjb2RlIHZhcmlhbnQgaW5zdGVhZC4NCj4gDQo+IAlpZiAoc3lzY3RsX2h1bmdfdGFza19w
YW5pYyAmJiB0b3RhbF9odW5nX3Rhc2sgPj0gc3lzY3RsX2h1bmdfdGFza19wYW5pYykNCj4gew0K
PiANCg0Kd2lsbCBmaXggaW4gbmV4dCB2ZXJzaW9uDQoNCnRoYW5rcw0KDQotTGkNCg0KPiANCj4g
UmVnYXJkcywNCj4gTWFya3VzDQoNCg==

