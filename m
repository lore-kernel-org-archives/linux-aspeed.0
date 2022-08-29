From: Sudip Mukherjee (Codethink) <sudipm.mukherjee@gmail.com>
Date: Mon, 29 Aug 2022 11:00:38 +0100
Subject: build failure of next-20220829 due to 108713a713c7 ("crypto: aspeed
 - Add HACE hash driver")
Message-ID: <YwyORp72cuDrVYdA@debian>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi All,

The builds of arm allmodconfig have failed to build next-20220829 with
the error:

ERROR: modpost: "aspeed_register_hace_hash_algs" [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!
ERROR: modpost: "aspeed_unregister_hace_crypto_algs" [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!
ERROR: modpost: "aspeed_register_hace_crypto_algs" [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!
ERROR: modpost: "aspeed_unregister_hace_hash_algs" [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!


git bisect pointed to 108713a713c7 ("crypto: aspeed - Add HACE hash driver")

I will be happy to test any patch or provide any extra log if needed.


--
Regards
Sudip
